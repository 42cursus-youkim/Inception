NAME := inception

CONFIG := srcs/docker-compose.yml
FLAGS := --project-name $(NAME) --file $(CONFIG)

COMPOSE := docker compose $(FLAGS)

VOLUME := $$HOME/data
HOST := "127.0.0.1 $$USER.42.fr"

reload: down build up

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs

ps:
	$(COMPOSE) ps

clean:
	$(COMPOSE) down --volumes --remove-orphans

purge:
	sudo rm -rf $(VOLUME)/*

run: reload

expose-port:
	echo $(HOST) >> /etc/hosts
	echo net.ipv4.ip_unprivileged_port_start=0 >> /etc/sysctl.d/local.conf
	sysctl --system

.PHONY: reload build up down logs ps clean purge run expose-port
