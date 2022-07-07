# include srcs/.env

NAME := inception

COMPOSE := docker compose

CONFIG := srcs/docker-compose.yml
FLAGS := --project-name $(NAME) --file $(CONFIG)
HOST := "127.0.0.1 youkim.42.fr"

reload: down build up

build:
	$(COMPOSE) $(FLAGS) build

up:
	$(COMPOSE) $(FLAGS) up

down:
	$(COMPOSE) $(FLAGS) down

logs:
	$(COMPOSE) $(FLAGS) logs

ps:
	$(COMPOSE) $(FLAGS) ps

clean:
	$(COMPOSE) $(FLAGS) down --volumes --remove-orphans

purge:
	rm -rf ~/data/*

run: reload

expose-port:
	echo "127.0.0.1  youkim.42.fr" >> /etc/hosts
	echo net.ipv4.ip_unprivileged_port_start=0 >> /etc/sysctl.d/local.conf
	sysctl --system

.PHONY: reload build up down logs ps clean purge run expose-port
