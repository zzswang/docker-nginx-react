# docker-nginx-react

## What is this

A docker base image for a Single Page App (eg. React), within nginx server,
clear url, push state friendly by default.

We use the minimalist Nginx image based on Alpine linux (~6 MB).

Actually it does nothing with react, no matter the app is made by React or any
other framework.

## Migrating from 0.2.0

Two envrionment variable name are changed:

* API_GATEWAY => APP_API_GATEWAY
* API_PLACEHOLDER => APP_API_PLACEHOLDER

For all envrionments start with APP_, it will dynamically subset while server
starting. You can put those envrionments in html/js/css files, we will handle it
gracefully.

The above two envrionments are used by nginx, but it may also be interested with
development. So we put APP_ prefix on them, make sure you can use them in your
code.

## Quick start

There are two ways to kick off:

### 1. Start the default container

**note:** link your app with this volume `-v /your/webapp:/app`.

```sh
docker run -d --name myapp -p 80:80 -v /your/webapp:/app zzswang/docker-nginx-react
```

### 2. Dockfile

notice: **we strongly suggest you follow this way**

```sh
FROM zzswang/docker-nginx-react:latest

ENV DEBUG=off

## Suppose your app is in the dist directory.
COPY ./dist /app
```

Then just publish your images, and run the container from it.

```sh
docker run -d -p 80:80 your_image
```

## Envrionments

* APP_DIR: the root direactory of your app running in the docker container,
  usally you do not need to change it.
* APP_PATH_PREFIX: some times you would want to put several sites under one
  domain, then sub path prefix is required.
* APP_API_PLACEHOLDER: An api call start with a specific path, then the server
  will redirect the request to APP_API_GATEWAY.
* APP_API_GATEWAY: work together with APP_API_PLACEHOLDER.
* CLIENT_BODY_TIMEOUT: body timeout.
* CLIENT_HEADER_TIMEOUT: header timeout.
* CLIENT_MAX_BODY_SIZE: maximum request body size.

### examples

#### APP_API_PLACEHOLDER && APP_API_GATEWAY

**note:** we suggest you call api with a full url with domain, make your api
server independently. But we need to take care of cross domain and https issues.

If your app calls api without domain, and not deploy behind a **Well
Structured** haproxy(or other forward proxy), you can turn on this option.

```sh
APP_API_PLACEHOLDER="/api/v1"
APP_API_GATEWAY="http://api.your.domain"
```

Then all url match `/api/v1` will redirect to `http://api.your.domain`. Please
notice that the `/api/v1` is stripped.

#### APP_PATH_PREFIX

Suppose you have a domain

```sh
www.books.com
```

You have two apps Computer and Math, want put them under the same domain.

```sh
http://www.books.com/computer
http://www.books.com/math
```

For App computer, setting

```sh
APP_PATH_PREFIX=/computer
```

You also need to take care about this path prefix in your APP. Like react
router(3.x), it could take a prefix option. We strongly suggest to use the same
envrionment in your source code. So this image will take care of it for you. For
example, in your router.js file:

```js
import useBasename from "history/lib/useBasename";
import { browserHistory } from "react-router";

export const myHistory = useBasename(() => browserHistory)({
  basename: `/${APP_PATH_PREFIX}`
});
```

## License

[MIT](LICENSE.txt)
