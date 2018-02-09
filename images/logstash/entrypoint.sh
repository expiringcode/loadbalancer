#!/bin/sh
set -e

# curl -XPUT -D- 'http://elasticsearch:9200/.kibana/doc/index-pattern:elk' \
#     -H 'Content-Type: application/json' \
#     -d '{"type": "index-pattern", "index-pattern": {"title": "logstash-*", "timeFieldName": "@timestamp"}}'


/usr/local/bin/docker-entrypoint