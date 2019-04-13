#!/bin/sh

docker-compose \
    -f docker-compose.yml \
    -f docker-compose-influx.yml \
    -f build/docker-compose-influx.yml \
    build

docker-compose \
    -f docker-compose.yml \
    -f docker-compose-influx.yml \
    -f build/docker-compose-influx.yml \
    push
