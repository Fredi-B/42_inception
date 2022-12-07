FROM debian:buster

# rm -rf... -> cache busting: (see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run \
# and https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update && apt-get install -y \
    mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# copy our config file
COPY 50-server.cnf /etc/mysql/mariadb.conf.d

# FLUSH PRIVILIGES  maybe not needed (see https://stackoverflow.com/questions/36463966/mysql-when-is-flush-privileges-in-mysql-really-needed)
# ALTER USER        give root a password. (root is the admin)
RUN service mysql start && \
    mysql -u root -e "CREATE DATABASE ${DB_NAME};" \
    mysql -u root -e "CREATE USER '${DB_USER}@'${DB_HOST}' IDENTIFIED BY '${DB_PASSWORD}';" \
    mysql -u root -e "GRANT ALL PRIVILIGES ON ${DB_NAME}.* TO '${DB_USER}'@'DB_HOST';" \
    mysql -u root -e "FLUSH PRIVILIGES;" \
    mysql -u root -e "ALTER USER 'root'@'${DB_ADMIN_HOST}' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"

# mysqld_safe "is a wrapper that starts mysqld with some extra safety features."
# "[I]f mysqld_safe notices that mysqld has crashed, [...][it, FB] will automatically restart mysqld."
# https://mariadb.com/kb/en/mysqld_safe/
CMD ["mysqld_safe"]