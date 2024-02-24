COMPOSE_FILE := ./srcs/docker-compose.yml
HOME := /home/pedperei

all:
	@echo "Usage: make [up|down|clean|clean-re|up-volumes|stop|fclean|delete_folders|images_clean|restart|volume_clean|container_clean|prune|connect|re-up]"

build:
	sudo docker-compose -f $(COMPOSE_FILE) build
	sudo mkdir -p $(HOME)/data/mysql
	sudo mkdir -p $(HOME)/data/wordpress

build-up: build up

up:
	sudo docker-compose -f $(COMPOSE_FILE) up

down:
	sudo docker-compose -f $(COMPOSE_FILE) down

down-volumes:
	sudo docker-compose -f $(COMPOSE_FILE) down -v

clean: images_clean
	sudo docker-compose -f $(COMPOSE_FILE) down -v --remove-orphans

stop:
	sudo docker-compose -f $(COMPOSE_FILE) stop

fclean: delete_folders 
	sudo docker stop $$(sudo docker ps -qa)  # Stop all containers
	sudo docker rm $$(sudo docker ps -qa) # Remove all containers
	sudo docker rmi -f $$(sudo docker images -qa) # Remove all images
	sudo docker volume rm $$(sudo docker volume ls -q) # Remove all volumes
	sudo docker network rm $$(sudo docker network ls -q) 2>/dev/null # Remove all networks

delete_folders:
	sudo rm -rf $(HOME)/data/mysql
	sudo rm -rf $(HOME)/data/wordpress

images_clean:
	sudo docker rmi $$(sudo docker images -q)

restart: down up

volume_clean:
	sudo docker volume rm $$(sudo docker volume ls -qf dangling=true)

container_clean:
	sudo docker rm $$(sudo docker ps -qa --no-trunc --filter "status=exited")

prune:
	sudo docker system prune -a

connect:
	sudo docker exec -it mariadb mysql -u root -p

re-up: down fclean build-up

.PHONY: up down clean clean-re up-volumes stop fclean delete_folders images_clean restart volume_clean container_clean prune connect_mariadb re-up