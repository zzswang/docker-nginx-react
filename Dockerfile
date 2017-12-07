FROM nginx:alpine
LABEL maintainer="zzswang@gmail.com"

ENV DEBUG=off \
	APP_DIR=/app \
	APP_PATH_PREFIX=/aSubSiteInParentDomainUseThisPath \
	APP_API_PLACEHOLDER=/allRequestStartOfthisPathIsAnApiCall \
	APP_API_GATEWAY="https://api.36node.com" \
	CLIENT_BODY_TIMEOUT=10 \
	CLIENT_HEADER_TIMEOUT=10 \
	CLIENT_MAX_BODY_SIZE=1024

COPY nginx-site.conf /etc/nginx/conf.d/app.conf.template
COPY start-nginx.sh /usr/sbin/start

RUN chmod u+x /usr/sbin/start

EXPOSE 80 443
WORKDIR ${APP_DIR}

CMD [ "start" ]
