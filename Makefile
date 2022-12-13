.phony: all clean fclean re prune pre

all:
	mkdir -p /home/fred/data
	mkdir -p /home/fred/data/wp_db
	mkdir -p /home/fred/data/wp_files
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up 

clean:
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down 

fclean:
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down  --volumes --rmi all
	sudo rm -rf /home/fred/data/wp_db
	sudo rm -rf /home/fred/data/wp_files

re: fclean all

prune:
	docker system prune -a -f

pre: fclean prune all
