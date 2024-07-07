# Use Alpine Linux as the base image
FROM alpine:latest

#installing curl
RUN apk add curl

# Install packages required for building Nginx
RUN apk add --no-cache \
    build-base \
    linux-headers \
    openssl-dev \
    pcre-dev \
    pcre \
    wget \
    zlib-dev
# Set the working directory
WORKDIR /tmp
# Download Nginx source code
ENV NGINX_VERSION 1.21.6
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && tar -zxvf nginx-${NGINX_VERSION}.tar.gz
# Compile Nginx from source
WORKDIR /tmp/nginx-${NGINX_VERSION}
RUN ./configure \
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
RUN rm -rf /tmp/nginx-${NGINX_VERSION} nginx-${NGINX_VERSION}.tar.gz \
    && apk del build-base linux-headers openssl-dev wget zlib-dev
# Do not remove pcre-dev here to keep the runtime library
# Copy custom configuration file and website content from the host to the container
COPY nginx.conf /etc/nginx/nginx.conf
# Optionally, uncomment the next line to copy website content
# COPY html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]