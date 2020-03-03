#!/bin/sh

docker-compose \
    -f docker-compose-dnsmasq.yml \
    up -d

if [ ! -f /etc/resolv/test ]; then
    sudo mkdir -pv /etc/resolver
    sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
fi