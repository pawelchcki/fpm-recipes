# fpm-recipes

TODO: polish up this documentation

## Initializing the build system

1) install vagrant from https://www.vagrantup.com/downloads.html
2) Run following commands:

```
vagrant up
```

## Docker base

Docker is used to provide common build environment that works fast on linux machines and can be managed by Dockerfiles.

### Reloading changes to Dockerfile:

```
vagrant reload
```

## Building packages - example usage
```
make consul-replicate TARGET=ubuntu1404
make
make consul-replicate recipes/consul-wikia-tools TARGET=ubuntu1204
```

###

Some ideas and code for this repo were borrowed from https://github.com/Graylog2/fpm-recipes
