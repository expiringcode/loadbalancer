# Loadbalancer

## Install

```bash
$ docker-compose -f docker-compose.yml -f docker-compose-elk.yml -f docker-compose-influx.yml up -d --build
```

## Purpose

The project aims to package a set of existing software to make webapp deployments fast, easy and secure.

### Advantages

- Automatically handled HTTPS configuration, load balancing with proxy
- Continuos logging and alerts monitoring your projects with very little effort
- Easy setup
- Access to logs without needing to access the server

## Design

### Main layer
	
- **Nginx** used as a proxy
- **[Dockgergen](https://github.com/jwilder/docker-gen)**
	- Creates nginx configuration automatically for containers. All it needs is a `VIRTUAL_HOST` environment varialble
- **Letsencrypt**
	- Automatically enables HTTPS on a container when the `LETSENCRYPT_HOST` and `LETSENCRYPT_EMAIL` environment variables are present.

### Logging

Logging is done in two ways,  using the ELK (elasticsearch) stack and using TICK (influxdata) stack. 

The two stacks measure different data. The first gives access to logs from all the containers while the second shows the impact each container has on the server resources.

### ELK

The ELK stack includes:

- Kibana
- Elasticsearch
- Logstash

Two more containers were added:

- `logspout`: Automatically catches logs from containers and pushes them to **Logstash**
- `elk_starter`: Configures elasticsearch for kibana and logstash and sets an index.

> Kibana (with x-pack enabled) offers authentication. It is set by default to:
> u: elastic 
> p: changeme
> u: kibana
> p: changeme

These users can be changed later from Kibana

### TICK

The TICK stack includes the following containers:

- Telegraf
- Chronograf
- Influxdb
- Kapacitor

It is configured to handle inputs both from the host system and from the docker socket to monitor all the containers.

> Chronograf can be configured to use github authentication

### Usage

You can use the full solution or combine parts of it.

- To install just the proxy (with letsencrypt) run 

```
docker-compose up -d --build
```

- To install the proxy and ELK use:

```
docker-compose -f docker-compose.yml -f docker-compose-elk.yml up -d --build
```

- Finally to install the proxy with just TICK run:

```
docker-compose -f docker-compose.yml -f docker-compose-influx.yml up -d --build
```

- To install everything run the following instead:

```
docker-compose -f docker-compose.yml -f docker-compose-elk.yml -f docker-compose-influx.yml up -d --build
```

> If you want to use TICK or ELK, you must start from the `proxy` yml, because they both use networks defined in docker-compose.yml. docker-compose-elk.yml and docker-compose-influx.yml extend docker-compose.yml

## Requirements

- The proxy stack with Nginx, Letsencrypt and Dockergen requires few resources being based on **Linux Alpine**. Altogether they need about *100MB* of disk space.
	- Nginx needs about **5MB** of RAM
	- Letsencrypt needs less than **4MB** of RAM
	- Dockergen uses less than **3MB** of RAM
- InfluxData stack nees about *200MB* of disk space.
	- InfluxDB uses an average of **200MB** of RAM
	- Chronograf on Idle uses about **9MB** of RAM
	- Telegraf uses around **12MB** of RAM instead
	- Kapacitor may need about **20MB** of RAM
- The ELK stack images have quite an impact needing more than *2.2GB* of disk space.
	- ElasticSearch uses at least **512MB** of RAM and can go up fast
	- Kibana requires about **200MB** of RAM on idle
	- Logstash requires a lot of memory as well with an average of 600MB so more than **512MB** of RAM
	- Logspout needs just **9MB** of RAM to monitor docker containers
	- elk_starter will die as soon as it's job is done so it won't require any resources


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

Nginx: 1.13

All the containers (where possible) are based on Alpine
