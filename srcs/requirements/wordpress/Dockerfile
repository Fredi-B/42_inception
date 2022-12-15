FROM debian:buster

# update && install in one RUN
# "ensures your Dockerfile installs the latest package versions" #cachebusting
# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)
# '-y' answers yes to all prompts
# 'rm -rf...' delete the apt cache, to prevent potential parsing errors #cachebusting
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
#
# php7.3-fpm    (https://packages.debian.org/buster/php && https://www.php.net/manual/en/install.fpm.php)
# php connects the containers
RUN apt-get update && apt-get install -y \
    php7.3-fpm \
    php7.3-mysql \
	mariadb-client \ 
	curl \
&&  rm -rf /var/lib/apt/lists/*

# copy custom wordpress config file from the host VM into the container
RUN mkdir -p /etc/php/7.3/fpm
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

# creates needed directory
# resolves the error: (Unable to create the PID file (/run/php/php7.3-fpm.pid).: No such file or directory)
RUN mkdir /run/php

# install WordPress Commandline tool in /usr/local/bin and rename to wp-cli
# && chmod execution rights, to use as command
# (https://code.tutsplus.com/articles/download-and-install-wordpress-via-the-shell-over-ssh--wp-24403)
# (https://www.dreamhost.com/blog/guide-to-wp-cli/#:~:text=The%20WP%2DCLI%20is%20a,faster%20using%20the%20WP%2DCLI)
# (https://wordpress.stackexchange.com/questions/293124/shortest-way-to-install-wp-cli)
RUN	curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp --silent \
&&	chmod +x ./usr/bin/wp

# COPY the setup_wp script
# chmod execution rights to launch it in local on our computer
# use it as ENTRYPOINT for the container
COPY ./tools/setup_wp.sh /var/www/wordpress/config.sh
RUN chmod +x /var/www/wordpress/config.sh
ENTRYPOINT ["var/www/wordpress/config.sh"]
