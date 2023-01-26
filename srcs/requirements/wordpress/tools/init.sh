#!/bin/bash

# Create php necessary folder if not present.
if [ -d /run/php ]
then
	echo '/run/php exists.'
else
	mkdir /run/php
fi

# Create wordpress config file.
if [ -f /var/www/wordpress/wp-config.php ]
then
	echo 'WP already configured'
else
	# Download and install wordpress.
	echo 'Download WordPress'
	wp core --allow-root download
	echo 'Configure WP'
	wp config create --allow-root \
			--dbname=$SQL_DATABASE \
			--dbuser=$SQL_USER \
			--dbpass=$SQL_PASSWORD \
			--dbhost=mariadb:3306
	echo 'Install WP'
	wp core install --allow-root \
			--url=$DOMAIN_NAME \
			--title='Inception' \
			--admin_user=$WP_USER1 \
			--admin_password=$WP_PASSWORD1 \
			--admin_email=$WP_EMAIL
	echo 'Create new user'
	wp user create $WP_USER2 $WP_EMAIL2 \
			--user_pass=$WP_PASSWORD2 \
			--allow-root
	
	chown -R www-data /var/www/wordpress
	chmod -R 755 /var/www/wordpress
	chmod -R 777 /var/www/wordpress/*.php
fi
echo "executing $@"
exec "$@"
