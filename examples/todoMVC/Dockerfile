FROM zzswang/docker-nginx-react:latest

ARG APP_VERSION

ENV APP_VERSION=${APP_VERSION:-0.0.0} \
  APP_GREETINGS="'Hello World'"

## Suppose your app is in the dist directory.
COPY ./dist /app