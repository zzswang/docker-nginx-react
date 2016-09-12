docker-nginx-react
=======

## What is this?

Support to run a react single page app within nginx server, push state friendly by default. Support base url and api proxy.

## Quick start

#### 1. Start the default container

**note:** link your app with this container `-v /your/webapp:/app`

```
docker run -d --name myapp -p 80:80 -v /your/webapp:/app zzswang/docker-nginx-react
```


#### 2. The app will put in a sub path, like http://your.domain/subpath/

**note:** use `-e BASE_URL="/subpath"`

```
// with base url
docker run -d --name myapp -p 80:80 -v /your/webapp:/app -e BASE_URL="/subpath" zzswang/docker-nginx-react
```


#### 3. API proxy

If your app will not deploy behind a **Well Structured** nginx or other forward proxy, you can turn on this option. Please use `-e API_REGEX="/api_vd?" -e API_GATEWAY="https://api.your.domain"`

```
docker run -d --name myapp -p 80:80 -v /your/webapp:/app -e API_REGEX="/api_vd?" -e API_GATEWAY="https://api.your.domain" zzswang/docker-nginx-react
```

**note:** some projects would like to make the ajax call with full url, then you do not need to care about the api proxy things. But we do need to take care of cross domain and https issues. I can't tell which way is better, welcome to post your ideas about it.

#### 4. Dockfile

Another way is we can write a new dockerfile from this image. 

```
FROM zzswang/docker-nginx-react
MAINTAINER zzswang@gmail.com

ENV BASE_URL=/data \
    API_REGEX=/api_vd? \ 
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