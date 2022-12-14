FROM debian:buster

# update && install in one RUN
# "ensures your Dockerfile installs the latest package versions" #cachebusting
# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)
# '-y' answers yes to all prompts
# 'rm -rf...' delete the apt cache, to prevent potential parsing errors #cachebusting
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update && apt-get install -y \
    mariadb-server \
 && rm -rf /var/lib/apt/lists/*

# copy our mariadb config and setup files from the host VM into the container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d
COPY ./tools/setup_db.sql /

# start mysql, set it up, stop it and delete setup_db.sql file
RUN service mysql start ; \
    mysql < setup_db.sql ; \
    rm -rf setup_db.sql

# mysqld_safe "is a wrapper that starts mysqld with some extra safety features."
# "[I]f mysqld_safe notices that mysqld has crashed, [...][it, FB] will automatically restart mysqld."
# (https://mariadb.com/kb/en/mysqld_safe/)
CMD ["mysqld_safe"]
