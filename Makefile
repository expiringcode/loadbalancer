include .env
export $(shell sed 's/=.*//' .env)

default: build

build-lb:
	@echo "Building Load Balancer"
	@docker-compose -f ./docker-compose.yml -f ./build/docker-compose.yml build
	@docker-compose -f ./docker-compose.yml -f ./build/docker-compose.yml push

build-dns:
	@echo "Building DNS"
	@docker-compose -f docker-compose-dnsmasq.yml -f build/docker-compose-dnsmasq.yml build
	@docker-compose -f docker-compose-dnsmasq.yml -f build/docker-compose-dnsmasq.yml push

build: build-lb build-dns build-main

deploy-node-management:
	@echo "Deploying Node Management"
	@docker-compose -f docker-compose-node-management.yml up -d

deploy-lb:
	@echo "Deploying Load Balancer with Let's Encrypt"
	@docker-compose -f ./docker-compose.yml -f ./docker-compose-letsencrypt.yml up -d

deploy-dns:
	@echo "Deploying DNS"
	@docker-compose -f docker-compose-dnsmasq.yml up -d
	sh ./bin/dns-mac.sh

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