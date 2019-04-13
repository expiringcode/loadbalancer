#!/bin/sh

docker-compose \
    -f docker-compose.yml \
    -f docker-compose-elk.yml \
    -f build/docker-compose-elk.yml \
    build

docker-compose \
    -f docker-compose.yml \
    -f docker-compose-elk.yml \
    -f build/docker-compose-elk.yml \
    push
