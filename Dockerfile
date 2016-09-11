FROM nginx:latest
MAINTAINER zzswang@gmail.com

ENV BASE_URL="" \
    APP_DIR = "/app"

RUN mkdir -p ${APP_DIR}
COPY nginx-site.conf /etc/nginx/conf.d/mysite.template
RUN envsubst '$BASE_URL' < /etc/nginx/conf.d/mysite.template > /etc/nginx/conf.d/default.conf

EXPOSE 80/tcp
VOLUME ["${APP_DIR}"]
WORKDIR ${APP_DIR}
CMD nginx -g 'daemon off;'