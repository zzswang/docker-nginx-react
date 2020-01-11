FROM zzswang/docker-nginx-react:v0.10.4

ARG VERSION

ENV APP_VERSION=${VERSION} \
  APP_GREETINGS="'Hello World'"

## Suppose your app is in the dist directory.
COPY ./dist /app