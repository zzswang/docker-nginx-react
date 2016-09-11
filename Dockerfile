FROM nginx:latest
MAINTAINER zzswang@gmail.com

ENV BASE_URL="" \
    APP_DIR="/app"

RUN mkdir -p ${APP_DIR}
COPY nginx-site.conf /etc/nginx/conf.d/mysite.template
COPY start-nginx.sh /usr/local/bin/start-docker.sh
RUN chmod u+x /usr/local/bin/start-docker.sh

EXPOSE 80/tcp
VOLUME ["${APP_DIR}"]
WORKDIR ${APP_DIR}

ENTRYPOINT "/usr/local/bin/start-docker.sh"