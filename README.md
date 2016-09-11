docker-nginx-react
=======

## What is this?

Run react single page app within a nginx server

## Quick start

```
docker run -d --name myapp -p 80:80 zzswang/nginx-react
```

**note**: It will start the pre-configured cnpmjs.org server. You could use `open http://localhost:7002` to visit the homepage.


## License

[MIT](LICENSE.txt)