# Loadbalancer

## Install

```bash
$ docker-compose -f docker-compose.yml -f docker-compose-elk.yml -f docker-compose-influx.yml up -d --build
```

## Purpose

### Advantages

## Design

### Main layer
	
- Nginx used as a proxy
- (Dockgergen)[https://github.com/jwilder/dockergen]
	- Creates nginx configuration automatically for containers. All it needs is a `VIRTUAL_HOST` environment varialble
- Letsencrypt
	- Automatically enables HTTPS on a container when the `LETSENCRYPT_HOST` and `LETSENCRYPT_EMAIL` environment variables are present.

## Todo

- IP Filtering
- Canary testing
- Build letsencrypt without dockergen since we're using an external dockergen container

## Updating

InfluxData (TICK) stalk: 1.3-alpine
ElasticSearch (ELK) stalk: 6.2.0 (x-pack enabled)
Dockergen: jwilder/dockergen:latest
Letsencrypt: 
- Dockergen: 0.7.3
- Alpine: 3.3
- 