
all:
	docker compose -f ./srcs/docker-compose.yaml up --build

fclean:
	docker compose -f ./srcs/docker-compose.yaml down
	docker system prune

re: fclean all