#!/bin/sh

docker-compose \
    -f docker-compose.yml \
    -f build/docker-compose.yml \
    build

docker-compose \
    -f docker-compose.yml \
    -f build/docker-compose.yml \
    push
