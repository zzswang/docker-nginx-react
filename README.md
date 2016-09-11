docker-nginx-react
=======

## What is this?

Support to run a react single page app within nginx server, support push state by default. Support base url environment.

## Quick start

```
docker run -d --name myapp -p 80:80 -v /your/webapp:/app zzswang/docker-nginx-react

// with base url
docker run -d --name myapp -p 80:80 -v /your/webapp:/app \ 
    -e BASE_URL="/subpath" zzswang/docker-nginx-react
```

**note**: If with base url, you can put your web app under a sub path, like http://your.domain/subpath/webapp/


## License

[MIT](LICENSE.txt)