docker-nginx-react
=======

## What is this?

Support to run a react single page app within nginx server, push state friendly by default. Support base url and api proxy.

From v0.2.0, we use the minimalist Nginx image based on Alpine linux (~6 MB). And we remove BASE_URL, since in docker, it should serve as root.

## Quick start

There are three way to start:


#### 1. Start the default container

**note:** link your app with this volume `-v /your/webapp:/app`.

```
docker run -d --name myapp -p 80:80 -v /your/webapp:/app zzswang/docker-nginx-react
```


#### 2. API proxy

If your app will not deploy behind a **Well Structured** nginx or other forward proxy, you can turn on this option. Please use `-e API_PLACEHOLDER="/api/v1" -e API_GATEWAY="https://api.your.domain"`, then all url match `/api/v1` will redirect to `https://api.your.domain`.

```
docker run -d --name myapp -p 80:80 -v /your/webapp:/app -e API_PLACEHOLDER="/api/v1" -e API_GATEWAY="https://api.your.domain" zzswang/docker-nginx-react
```

**note:** some projects would like to make the ajax call with full url, then you do not need to care about the api proxy things. But we do need to take care of cross domain and https issues. I can't tell which way is better, welcome to post your ideas about it.

#### 3. Dockfile

Another way is we can write a new dockerfile from this image.

```
FROM zzswang/docker-nginx-react:latest
MAINTAINER zzswang@gmail.com

ENV APP_DIR=/app \
    API_PLACEHOLDER=/api/v1 \
    API_GATEWAY=https://api.your.damain

## Suppose your app is in the dist directory.
COPY ./dist /app
```

Then just publish your images, and run the container from it.

```
docker run -d -p 80:80 your_image
```

## License

[MIT](LICENSE.txt)
