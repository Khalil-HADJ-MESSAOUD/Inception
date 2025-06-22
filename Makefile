
all: up

up:
	sudo mkdir -p /home/$USER/data
	sudo mkdir -p /home/$USER/data/db_data
	sudo mkdir -p /home/$USER/data/wp_data
	sudo chown -R 999:999 /home/$USER/data/db_data
	# adjust perms here
	sudo chmod -R 777 /home/$USER/data/db_data
	sudo chown -R www-data:www-data /home/$USER/data/wp_data
	# adjust perms here
	sudo chmod -R 777 /home/$USER/data/wp_data
	docker compose -f ./srcs/docker-compose.yaml up --build

down:
	docker compose -f ./srcs/docker-compose.yaml down
	docker system prune

v:
	sudo rm -rf /home/khadj-me/data

cache-clear:
	docker builder prune
	docker system prune -a

clean-all: down v cache-clear

re: down all