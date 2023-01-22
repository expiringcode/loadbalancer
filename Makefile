include .env
export $(shell sed 's/=.*//' .env)

default: build

build-prepare:
	@echo "Prepare Build System"
	@docker buildx create --name mybuilder --driver docker-container --bootstrap
	@docker buildx use mybuilder
	@docker buildx inspect

build-lb:
	@echo "Building Load Balancer"
	@docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64 ./images/nginx -t ${REGISTRY}/nginx:latest --push
	@docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64 ./images/dockergen -t ${REGISTRY}/dockergen:latest --push

build-dns:
	@echo "Building DNS"
	@docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64 ./images/dnsmasq -t ${REGISTRY}/dnsmasq:latest --push

build: build-lb build-dns

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