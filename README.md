# Readme

This is the API for apisonator project.

The API must be the most simple and tolerant as possible to avoid extra
development for the [cli](https://github.com/apisonator/apisonator-cli).

The API store some relevant information for the [proxy](https://github.com/apisonator/api-proxy-openresty) in redis.


## Requirents

- Ruby
- Redis

## How to use

```
$ bundler
$ rake db:create
$ rake db:schema:load
$ rails server
```
