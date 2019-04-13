#!/bin/sh

docker-compose \
    -f docker-compose.yml \
    -f build/docker-compose.yml \
    -f docker-compose-letsencrypt.yml \
    -f build/docker-compose-letsencrypt.yml \
    build

docker-compose \
    -f docker-compose.yml \
    -f build/docker-compose.yml \
    -f docker-compose-letsencrypt.yml \
    -f build/docker-compose-letsencrypt.yml \
    push
