FROM debian:buster

# Install Nginx dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpcre3 \
    libpcre3-dev \
    zlib1g-dev \
    wget \
    curl \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create nginx user and group
RUN groupadd -r nginx && useradd -r -g nginx nginx

WORKDIR /tmp

ENV NGINX_VERSION 1.21.6
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && tar -zxvf nginx-${NGINX_VERSION}.tar.gz
    
# Compile Nginx from source
WORKDIR /tmp/nginx-${NGINX_VERSION}

RUN ./configure \
    --user=nginx \
    --group=nginx \
    --sbin-path=/usr/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --with-pcre \
    --with-http_ssl_module \
    && make \
    && make install

# Cleanup unnecessary files
WORKDIR /

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MO/L=BG/O=1337/OU=student/CN=youssef.42.ma"

RUN rm -rf /tmp/nginx-${NGINX_VERSION} nginx-${NGINX_VERSION}.tar.gz
RUN apt-get remove -y build-essential libpcre3-dev zlib1g-dev wget

# Do not remove pcre-dev here to keep the runtime library

COPY ./tools/nginx.conf /etc/nginx/nginx.conf
# RUN mkdir -p /etc/nginx/conf.d
# COPY ./conf/options-ssl-nginx.conf /etc/nginx/conf.d/options-ssl-nginx.conf;
# COPY ./conf/options-ssl-nginx.conf /etc/nginx/options-ssl-nginx.conf;

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

# FROM debian:buster


# # Install Nginx dependencies
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     libpcre3 \
#     libpcre3-dev \
#     zlib1g-dev \
#     wget \
#     curl \
#     libssl-dev \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*


# WORKDIR /tmp

# ENV NGINX_VERSION 1.21.6
# RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
#     && tar -zxvf nginx-${NGINX_VERSION}.tar.gz
    
# # Compile Nginx from source
# WORKDIR /tmp/nginx-${NGINX_VERSION}

# RUN ./configure \
#     --sbin-path=/usr/sbin/nginx \
#     --conf-path=/etc/nginx/nginx.conf \
#     --error-log-path=/var/log/nginx/error.log \
#     --http-log-path=/var/log/nginx/access.log \
#     --with-pcre \
#     --with-http_ssl_module \
#     && make \
#     && make install

# # Cleanup unnecessary files
# WORKDIR /

# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MO/L=BG/O=1337/OU=student/CN=youssef.42.ma"

# RUN rm -rf /tmp/nginx-${NGINX_VERSION} nginx-${NGINX_VERSION}.tar.gz
# RUN apt-get remove -y build-essential libpcre3-dev zlib1g-dev wget

# # Do not remove pcre-dev here to keep the runtime library

# COPY ./tools/nginx.conf /etc/nginx/nginx.conf
# COPY tools/options-ssl-nginx.conf /etc/nginx/options-ssl-nginx.conf;
# COPY tools/options-ssl-nginx.conf /etc/nginx/conf.d/options-ssl-nginx.conf;

# # COPY ./tools/config.sh /tmp/config.sh
# # RUN chmod +x /tmp/config.sh


# EXPOSE 443 

# # CMD [ "./tmp/config.sh" ]

# CMD [ "nginx", "-g", "daemon off;" ]