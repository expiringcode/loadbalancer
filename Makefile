include .env
export $(shell sed 's/=.*//' .env)

default: build

build-lb:
	@echo "Building Load Balancer with Let's Encrypt"
	@docker-compose -f ./docker-compose.yml -f ./build/docker-compose.yml -f ./build/docker-compose-letsencrypt.yml build
	@docker-compose -f ./docker-compose.yml -f ./build/docker-compose.yml -f ./build/docker-compose-letsencrypt.yml push

build-dns:
	@echo "Building DNS"
	@docker-compose -f docker-compose-dnsmasq.yml -f build/docker-compose-dnsmasq.yml build
	@docker-compose -f docker-compose-dnsmasq.yml -f build/docker-compose-dnsmasq.yml push

build-elk:
	@echo "Building Elastic Stack"
	@docker-compose -f docker-compose.yml -f docker-compose-elk.yml -f build/docker-compose-elk.yml build
	@docker-compose -f docker-compose.yml -f docker-compose-elk.yml -f build/docker-compose-elk.yml push

build-le:
	@echo "Building Let's Encrypt"
	@docker-compose -f docker-compose.yml -f build/docker-compose.yml -f docker-compose-letsencrypt.yml -f build/docker-compose-letsencrypt.yml build
	@docker-compose -f docker-compose.yml -f build/docker-compose.yml -f docker-compose-letsencrypt.yml -f build/docker-compose-letsencrypt.yml push

build-main: 
	@echo "Building Main Stack"
	@docker-compose -f docker-compose.yml -f build/docker-compose.yml build
	@docker-compose -f docker-compose.yml -f build/docker-compose.yml push

build-tick:
	@echo "Building Influx Stack"
	@docker-compose -f docker-compose.yml -f docker-compose-influx.yml -f build/docker-compose-influx.yml build
	@docker-compose -f docker-compose.yml -f docker-compose-influx.yml -f build/docker-compose-influx.yml push

build: build-lb build-dns build-elk build-le build-main build-tick

deploy-node-management:
	@echo "Deploying Node Management"
	@docker-compose -f docker-compose-node-management.yml up -d

deploy-lb:
	@echo "Deploying Load Balancer with Let's Encrypt"
	@docker-compose -f ./docker-compose.yml -f ./docker-compose-letsencrypt.yml up -d

deploy-dns:
	@echo "Deploying DNS"
	@docker-compose -f docker-compose-dnsmasq.yml up -d

deploy-elk:
	@echo "Deploying Elastic Stack"
	@docker-compose -f docker-compose.yml -f docker-compose-elk.yml up -d

deploy-tick:
	@echo "Deploying Influx Stack"
	@docker-compose -f docker-compose.yml -f docker-compose-influx.yml up -d

deploy-nginx:
	@echo "Deploying Local Stack"
	@docker-compose -f docker-compose.yml up -d

deploy-local: deploy-nginx deploy-dns

deploy: deploy-lb deploy-node-management

clean: 
	@echo "Cleaning"
	@docker-compose -f docker-compose.yml -f docker-compose-letsencrypt.yml -f docker-compose-dnsmasq.yml -f docker-compose-elk.yml -f docker-compose-influx.yml -f docker-compose-node-management.yml  down -v --remove-orphans
	@docker-compose -f docker-compose-node-management.yml down -v --remove-orphans

.PHONY: build deploy