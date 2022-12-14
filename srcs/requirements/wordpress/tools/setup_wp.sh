#!/bin/bash
# (https://www.youtube.com/watch?v=9E1lyVyh4xc)
# (https://wordpress.org/support/article/creating-database-for-wordpress/#using-the-mysql-client)

# change directory to /var/www/wordpress
cd /var/www/wordpress

wp core download --allow-root

# create wp-config.php file and configure the wp instance to accept the MariaDB databank
wp core config	\
				--dbname=$WP_DB_NAME \
				--dbuser=$WP_DB_USER \
				--dbpass=$WP_DB_PASSWORD \
				--dbhost=$WP_DB_HOST \
				--allow-root

# install the wp instance and set the admin user and general infos like title and url
wp core install \
				--admin_user=$WP_ADMIN_USER \
				--admin_password=$WP_ADMIN_PASSWORD \
				--admin_email=$WP_ADMIN_MAIL \
				--title=$WP_TITLE \
				--url=$WP_URL \
				--allow-root

# create the first non-admin user
wp user create \
				$WP_USER \
				$WP_USER_MAIL \
				--role=author \
				--user_pass=$WP_USER_PASSWORD \
				--allow-root

# cd back to where you were before
cd -

# Start php-fpm to respond to FastCGI requests and force it to stay in the foreground
php-fpm7.3 -F
