# Use Debian as the base image
FROM debian:buster-slim


# # Install necessary packages for MySQL client installation
# RUN apt-get update && apt-get install -y wget lsb-release gnupg

# # Download and install MySQL APT config, add GPG key, update package list, and install MySQL client
# RUN apt-get update && apt-get install -y lsb-release inetutils-tools
# RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.24-1_all.deb
# RUN DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.24-1_all.deb
# RUN apt-get update
# RUN apt install -y mysql-client
# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg2 \
    ca-certificates \
    lsb-release \
    apt-transport-https \
    php-fpm \
    php-mysql \
    php-mbstring \
    php-xml \
    php-gd \
    php-curl \
    php-zip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Before unzipping WordPress, create the /var/www/html directory
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html


# Then proceed with downloading and unzipping WordPress
RUN curl -o wordpress.zip -fSL "https://wordpress.org/latest.zip" \
    && unzip wordpress.zip -d /var/www/html/ \
    && rm wordpress.zip \
    && chown -R www-data:www-data /var/www/html/wordpress


# # Configure PHP-FPM
# # Note: Adjust the PHP-FPM pool configuration as necessary
# RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf \
#     && sed -i 's/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = 127.0.0.1/' /etc/php/7.3/fpm/pool.d/www.conf

# Set working directory to WordPress
WORKDIR /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm7.3", "-F"]