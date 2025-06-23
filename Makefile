
all: up

up:
	mkdir -p /home/$(USER)/data
	mkdir -p /home/$(USER)/data/db_data
	mkdir -p /home/$(USER)/data/wp_data
	docker compose -f ./srcs/docker-compose.yaml up --build

down:
	docker compose -f ./srcs/docker-compose.yaml down
	docker system prune

v:
	docker volume rm wp_data
	docker volume rm db_data
	sudo rm -rf /home/khadj-me/data

cache-clear:
	docker builder prune
	docker system prune -a

clean-all: down v cache-clear

re: down all