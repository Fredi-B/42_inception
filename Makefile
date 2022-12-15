# tells the Makefile that these are rules not files.
# avoids conflicts and improves performance.
.phony: all clean fclean re prune pre

# Build and run all containers for LEMP stack via docker-compose.yml
# '--env-file' tells docker-compose where to find the .env file  
# creates necessary directories first
all:
	mkdir -p /home/fred/data
	mkdir -p /home/fred/data/wp_db
	mkdir -p /home/fred/data/wp_files
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up 

# Stop all containers for LEMP stack via docker-compose.yml
clean:
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down 

# Stop all containers for LEMP stack via docker-compose.yml down
# '--volumes':		Remove named volumes declared in the `volumes` section of the Compose file and
# 					anonymous volumes attached to containers
# '-rmi all':		Remove all images belonging to the LEMP stack
# 'sudo rm -rf...':	Delete all files in the database and wordpress files volumes on the host VM
fclean:
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down  --volumes --rmi all
	sudo rm -rf /home/fred/data/wp_db
	sudo rm -rf /home/fred/data/wp_files

# Clean up and rerun docker-compose
re: fclean all

# ==========| BE AWARE: For debugging purposes only! |========== #
# Removes all unused containers, networks and images on the system
# '-a':	not just dangling ones
# '-f':	Doesn't prompt for confirmation!
prune:
	docker system prune -a -f

# ==========| BE AWARE: For debugging purposes only! |========== #
# Clean up, prune and rerun docker-compose
pre: fclean prune all
