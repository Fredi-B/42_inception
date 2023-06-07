include srcs/.env
# ==========| BE AWARE: The project was written for a vm. Some rules may cause problems with Docker.|========== #
# ==========| BE AWARE: Restart Docker and delete every related image and volume solved it on my Mac |========== #

# tells the Makefile that these are rules not files.
# avoids conflicts and improves performance.
.phony: all clean fclean re prune pre

# Build and run all containers for LEMP stack via docker-compose.yml
# '--env-file':	tells docker-compose where to find the .env file
# '-d':			detached mode: run container in the background
# creates necessary directories first
all:
	mkdir -p $(WP_DB_DIRECTORY)
	mkdir -p $(WP_DB_DEVICE)
	mkdir -p $(WP_FILES_DEVICE)
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d

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
	rm -rf $(WP_DB_DEVICE)
	rm -rf $(WP_FILES_DEVICE)

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
