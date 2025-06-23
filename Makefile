USER = khadj-me

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
	sudo rm -rf /home/$(USER)/data

cache-clear:
	docker builder prune
	docker system prune -a

clean-all: down v cache-clear

logs:
	@if [ -z "$(CONTAINER)" ]; then \
		echo "Erreur : il faut passer CONTAINER=nom_du_container"; \
		exit 1; \
	else \
		docker logs -f $(CONTAINER); \
	fi

re: down all

reset-volumes:
	@echo "Suppression des volumes Docker wp_data et db_data..."
	docker volume rm wp_data db_data || true
	@echo "Suppression des dossiers locaux de données..."
	rm -rf /home/$(USER)/data/db_data /home/$(USER)/data/wp_data
