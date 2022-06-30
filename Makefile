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

clean: down
	sudo rm -rf $(VOLUME)/*

run: reload

.PHONY: build up down logs ps reload clean run
