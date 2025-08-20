
all: up

up:
	sudo mkdir -p /home/khadj-me/data
	sudo mkdir -p /home/khadj-me/data/db_data
	sudo mkdir -p /home/khadj-me/data/wp_data
	sudo chown -R 999:999 /home/khadj-me/data/db_data
	sudo chown -R 1000:1000 /home/khadj-me/data/wp_data
	sudo chmod -R 777 /home/khadj-me/data/db_data
	sudo chmod -R 777 /home/khadj-me/data/wp_data
	docker-compose -f ./srcs/docker-compose.yml up --build

down:
	docker-compose -f ./srcs/docker-compose.yml down -v
	docker system prune

v:
	sudo rm -rf /home/khadj-me/data

cache-clear:
	docker builder prune
	docker system prune -a

clean-all: down v cache-clear

re: down all