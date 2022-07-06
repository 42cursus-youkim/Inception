# include srcs/.env

NAME := inception

COMPOSE := docker compose

CONFIG := srcs/docker-compose.yml
FLAGS := --project-name $(NAME) --file $(CONFIG)
HOST := "127.0.0.1 youkim.42.fr"

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

reload: down build up

clean:
	$(COMPOSE) $(FLAGS) down --volumes --remove-orphans

run: reload

expose-port:
	echo "127.0.0.1  youkim.42.fr" >> /etc/hosts
	echo net.ipv4.ip_unprivileged_port_start=0 >> /etc/sysctl.d/local.conf
	sysctl --system

.PHONY: build up down logs ps reload clean run
