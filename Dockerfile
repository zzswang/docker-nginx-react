FROM smebberson/alpine-nginx
MAINTAINER zzswang@gmail.com

ENV APP_DIR="/app" \
    API_PLACEHOLDER="/defaultnomeaningregexmustnotmatch" \
    API_GATEWAY="https://api.36node.com"

RUN mkdir -p ${APP_DIR} \
      \
    	# Bring in gettext so we can get `envsubst`, then throw
    	# the rest away. To do this, we need to install `gettext`
    	# then move `envsubst` out of the way so `gettext` can
    	# be deleted completely, then move `envsubst` back.
    	&& apk add --no-cache --virtual .gettext gettext \
    	&& mv /usr/bin/envsubst /tmp/ \
    	\
    	&& export runDeps="$( \
    		scanelf --needed --nobanner /usr/sbin/nginx /usr/lib/nginx/modules/*.so /tmp/envsubst \
    			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
    			| sort -u \
    			| xargs -r apk info --installed \
    			| sort -u \
    	)" \
    	&& apk add --no-cache --virtual .nginx-rundeps ${runDeps} \
    	# && apk del .build-deps \
    	&& apk del .gettext \
    	&& mv /tmp/envsubst /usr/local/bin/ \
      \
      # forward request and error logs to docker log collector
      && ln -sf /dev/stdout /var/log/nginx/access.log \
      && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx-site.conf /etc/nginx/conf.d/app.conf.template
COPY start-nginx.sh /etc/services.d/nginx/run

# RUN chmod u+x /etc/services.d/nginx/run

EXPOSE 80 443
VOLUME ["${APP_DIR}"]
WORKDIR ${APP_DIR}
