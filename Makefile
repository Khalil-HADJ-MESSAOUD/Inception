
all:
	docker compose -f ./srcs/docker-compose.yaml up --build -d

fclean:
	docker compose -f ./srcs/docker-compose.yaml down -v

re: fclean all