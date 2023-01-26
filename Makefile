## VARIABLES

WORKDIR	= srcs
COMPOSE_FILE = ${WORKDIR}/docker-compose.yml
VOLUMEDIR = /home/aalleon/data
VOLUMEWP  = ${VOLUMEDIR}/wordpress
VOLUMESQL = ${VOLUMEDIR}/mysql

## RULES

all: up

up:
	@docker compose -f ${COMPOSE_FILE} up -d

down:
	@docker compose -f ${COMPOSE_FILE} down

clean: down
	@docker container rm -f nginx wordpress mariadb

fclean: clean
	docker image rm -f srcs-nginx-service srcs-wordpress-service srcs-mariadb-service
	docker volume rm -f srcs_mariadb_volume srcs_wordpress_volume
	sudo rm -rf ${VOLUMEWP}/*
	sudo rm -rf ${VOLUMESQL}/*

re: fclean all

info:
	@docker ps && echo
	@docker image ls -a && echo
	@docker network ls && echo
	@docker volume ls && echo

mariadb:
	@docker exec -it mariadb /bin/bash

wordpress:
	@docker exec -it wordpress /bin/bash

nginx:
	@docker exec -it nginx /bin/bash

.PHONY: all clean fclean re up down info mariadb wordpress nginx

