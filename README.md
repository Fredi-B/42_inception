# ft_inception

This project aims to broaden the knowledge of system administration by using Docker to set up a LEMP stack (Linux, Nginx, MySQL, and PHP).

## Table of Contents
- [Requirements](#requirements)
- [Installation and Usage](#installation-and-usage)
- [Description](#description)
- [Infrastructure set up](#infrastructure-set-up)
- [Some Rules](#some-rules)

## Requirements

install with `sudo apt-get install` if needed:
- gcc
- make
- ssh
- docker-compose  

## Installation and Usage

1. Clone the repository: `git clone git@github.com:Fredi-B/42_inception.git`
2. Navigate to the project directory: `cd 42_inception`
3. Build the Docker images and set up the application: `make all`
4. Access the application through your web browser: `https://fbechtol.42.fr`

## Description

This project consists of setting up a small infrastructure. Here is an example diagram of the expected result:

![Diagram of the expected result:](https://github.com/Fredi-B/42_inception/assets/79904261/a02adc36-87d5-4e5c-8f42-26b7a0cdd41e)


Each service has to run in a dedicated container. You also have to write your own Dockerfiles, one per service. The Dockerfiles must be called in your `docker-compose.yml` by your Makefile. It means you have to build the Docker images of your project yourself. It is forbidden to pull ready-made Docker images or use services such as DockerHub (except for Alpine/Debian).

- This project needs to be done on a Virtual Machine.
- A Makefile is required. It must set up your entire application (i.e., it has to build the Docker images using `docker-compose.yml`).
- This project requires putting into practice concepts that you may not have learned yet. We advise you to read a lot of documentation related to Docker usage and anything else that will be helpful in completing this assignment.

## Infrastructure set up

You need to set up the following:

- A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
- A Docker container that contains WordPress + php-fpm (installed and configured) without NGINX.
- A Docker container that contains MariaDB without NGINX.
- A volume that contains your WordPress database.
- A second volume that contains your WordPress website files.
- A docker-network that establishes the connection between your containers.

Your containers must restart in case of a crash.

## Some Rules

- Using `network: host`, `--link`, or `links:` is forbidden. The network line must be present in your `docker-compose.yml` file.
- Your containers must not be started with a command running an infinite loop. This applies to any command used as an entrypoint or in entrypoint scripts.
- In your WordPress database, there must be two users, one of them being the administrator.
- Your volumes will be available in the `/home/login/data` folder of the host machine using Docker. Replace `login` with your own login.
- The latest tag is prohibited.
- No password must be present in your Dockerfiles.
- It is mandatory to use environment variables.
- Use a `.env` file to store environment variables. Place the `.env` file at the root of the `srcs`
