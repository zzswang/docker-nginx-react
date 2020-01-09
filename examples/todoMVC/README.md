# TODOMVC

example from redux TodoMVC

show how to use this nginx image to serve such SPA App.

```sh
docker build --build-arg APP_VERSION=v0.2.0 -t todo .
docker run -d -p 8080:80 todo
```

visit todo in your browser [http://localhost:8080](http://localhost:8080)
