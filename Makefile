YML_PATH = srcs/docker-compose.yml

all: build up

build:
	docker-compose -f $(YML_PATH) build

up:
	docker-compose -f $(YML_PATH) up

down:
	docker-compose -f $(YML_PATH) down

clean:
	docker-compose -f  $(YML_PATH) down --volumes --rmi all

fclean: clean
	docker system prune -a --volumes --force
	if [ "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	if [ "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); fi
	if [ "$$(docker images -qa)" ]; then docker rmi -f $$(docker images -qa); fi
	if [ "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -qf dangling=true); fi
	if [ "$$(docker network ls -q --filter type=custom)" ]; then docker network rm $$(docker network ls -q --filter type=custom); fi
	sudo rm -rf /home/pedperei/data/mysql/*
	sudo rm -rf /home/pedperei/data/wordpress/*

re: fclean build up

logs:
	docker compose -f $(YML_PATH) logs

info-docker:
	docker compose -f $(YML_PATH) ps

info-volume:
	docker volume ls

info-network:
	docker network ls

inspect-mariadb:
	docker volume inspect mariadb_data

inspect-wordpress:
	docker volume inspect wordpress_data

connect-mariadb:
	docker exec -it mariadb mysql -u root -p

connect-wordpress:
	docker exec -it wordpress /bin/bash

# Declare the targets as phony to avoid conflicts with file names
.PHONY: all build up down fclean re logs info-docker info-volume info-network inspect-mariadb inspect-wordpress connect-mariadb connect-wordpress