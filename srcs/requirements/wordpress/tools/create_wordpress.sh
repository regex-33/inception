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


wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# 2. **redis-cache**: This command installs and activates a plugin that is actually known and available in the WordPress plugin repository.\
#       The `redis-cache` plugin enables WordPress to use Redis for object caching. Object caching involves storing database query results in Redis \
#       to speed up page loads and reduce database load by avoiding repeated queries for the same objects. This plugin provides an interface in the WordPress admin \
#       to manage Redis cache settings and includes features like flushing the Redis cache, enabling or disabling object caching, and configuring connection parameters \
#       to the Redis server.
.


wp plugin install redis-cache --activate --allow-root
 

wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root
# # set the database number to 0 it's mean the default database
wp config set WP_REDIS_DATABASE 0 --allow-root
wp redis enable --allow-root
wp plugin update --all --allow-root

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
mkdir /run/php

exec /usr/sbin/php-fpm7.3 -F
