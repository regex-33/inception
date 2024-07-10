#!/bin/sh

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp

mkdir -p /var/www/html
cd /var/www/html
rm -rf *

wp core download --allow-root

sed -i "s/username_here/$WP_DATABASE_USR/g" wp-config-sample.php
sed -i "s/password_here/$WP_DATABASE_PWD/g" wp-config-sample.php
sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
sed -i "s/database_name_here/$WP_DATABASE_NAME/g" wp-config-sample.php

cp wp-config-sample.php wp-config.php

# mv /wp-config.php /var/www/html/wp-config.php

wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

#wp theme install astra --activate --allow-root

wp plugin update --all --allow-root

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

mkdir /run/php


exec /usr/sbin/php-fpm7.3 -F

