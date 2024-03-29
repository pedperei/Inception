# Name of the project
NAME = inception

# Build the Docker containers defined in the docker-compose.yml file
build:
# -f: Specify an alternate compose file
# --build: Build images before starting containers
# -d: Detached mode: Run containers in the background
	docker-compose -f srcs/docker-compose.yml up --build

clean:
	docker-compose -f srcs/docker-compose.yml down --volumes --rmi all

fclean: clean
# prune: Remove unused data
# -a: Remove all unused images not just dangling ones
# --volumes: Prune volumes
# --force: Do not prompt for confirmation
	docker system prune -a --volumes --force
	docker network ls -q -f "driver=custom" | xargs -r docker network rm 2>/dev/null
	sudo rm -rf /home/pedperei/data/mysql/*
	sudo rm -rf /home/pedperei/data/wordpress/*

re: fclean build

logs:
	docker-compose -f srcs/docker-compose.yml logs
info:
	@echo "Containers:"
	@docker ps -a
	@echo "------------------------------------------------------------"
	@echo "Images:"
	@docker images -a
	@echo "------------------------------------------------------------"
	@echo "Volumes:"
	@docker volume ls
	@echo "------------------------------------------------------------"
	@echo "Networks:"
	@docker network ls
	@echo "------------------------------------------------------------"

connect-mariadb:
	docker exec -it mariadb mysql -u root -p

connect-wordpress:
	docker exec -it wordpress /bin/bash

# Declare the targets as phony to avoid conflicts with file names
.PHONY: build clean fclean re logs info connect