FROM debian:buster

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-redis \
    php-json \
    php-mbstring \
    php-zip \
    php-gd \
    php-curl \
    php-xml \
    php-intl \
    php-bcmath \
    git \
    && apt-get clean

# Clone phpRedisAdmin and its vendor
RUN git clone https://github.com/erikdubbelboer/phpRedisAdmin.git /var/www/html/phpRedisAdmin \
    && git clone https://github.com/nrk/predis.git /var/www/html/phpRedisAdmin/vendor

COPY ./conf/config.inc.php /var/www/html/phpRedisAdmin/includes/config.inc.php

RUN sed -ri -e 's!/var/www/html!/var/www/html/phpRedisAdmin!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!/var/www/html/phpRedisAdmin!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN chown -R www-data:www-data /var/www/html/phpRedisAdmin

#Enabling mod_rewrite: Allows your application to use URL rewriting, which is often necessary for routing and URL manipulation.
RUN a2enmod rewrite
RUN service apache2 restart

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]