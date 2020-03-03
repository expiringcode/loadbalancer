#!/bin/sh

docker-compose \
    -f docker-compose-dnsmasq.yml \
    -f build/docker-compose-dnsmasq.yml \
    build

docker-compose \
    -f docker-compose-dnsmasq.yml \
    -f build/docker-compose-dnsmasq.yml \
    push
