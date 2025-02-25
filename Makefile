# Makefile for Docker management
.PHONY: all build up down stop remove volumes clean clear-all re help

SHELL := /bin/bash -e

DOCKER_COMPOSE := docker-compose

help:
	@echo "Available targets:"
	@echo "  all       - Build and start containers (default)"
	@echo "  build     - Build containers"
	@echo "  up        - Start containers in detached mode"
	@echo "  down      - Stop and remove containers, networks"
	@echo "  stop      - Stop running containers"
	@echo "  remove    - Remove containers and images for this project"
	@echo "  volumes   - Remove volumes (with confirmation)"
	@echo "  clean     - Stop and remove containers"
	@echo "  clear-all - Remove all project-related resources (DANGEROUS)"
	@echo "  re        - Rebuild from scratch"
	@echo "  help      - Show this help message"

all: build up

build:
	@echo "Building containers..."
	$(DOCKER_COMPOSE) build

up:
	@mkdir -p /home/regex-33/data/{wordpress_data,mariadb_data}
	@chmod -R 755 /home/regex-33/data
	@echo "Starting containers..."
	$(DOCKER_COMPOSE) up -d

down:
	@echo "Stopping and removing containers..."
	$(DOCKER_COMPOSE) down

stop:
	@echo "Stopping containers..."
	$(DOCKER_COMPOSE) stop

remove:
	@echo "Removing project containers and images..."
	$(DOCKER_COMPOSE) down --rmi all

volumes:
	@read -p "This will remove ALL project volumes. Continue? [y/N] " ans; \
	if [ "$$ans" == "y" ] || [ "$$ans" == "Y" ]; then \
		$(DOCKER_COMPOSE) down -v; \
	else \
		echo "Volume removal cancelled"; \
	fi

clean: down

clear-all:
	@read -p "This will remove ALL Docker resources (containers, images, volumes). Continue? [y/N] " ans; \
	if [ "$$ans" == "y" ] || [ "$$ans" == "Y" ]; then \
		echo "Removing all Docker resources..."; \
		sudo docker stop $$(sudo docker ps -aq) 2>/dev/null || true; \
		sudo docker rm -f $$(sudo docker ps -aq) 2>/dev/null || true; \
		sudo docker rmi -f $$(sudo docker images -aq) 2>/dev/null || true; \
		sudo docker volume rm -f $$(sudo docker volume ls -q) 2>/dev/null || true; \
		sudo docker system prune -a --volumes -f; \
	else \
		echo "Clear-all operation cancelled"; \
	fi

re: down build up

# Add safety checks
check-%:
	@if $$(hash $* 2> /dev/null); then \
		echo "$* is installed"; \
	else \
		echo "$* is required"; exit 1; \
	fi

# Dependency checks
pre-check: check-docker check-docker-compose

check-docker:
	@command -v docker >/dev/null 2>&1 || { echo >&2 "Docker is required but not installed. Aborting."; exit 1; }

check-docker-compose:
	@command -v docker-compose >/dev/null 2>&1 || { echo >&2 "Docker Compose is required but not installed. Aborting."; exit 1; }
