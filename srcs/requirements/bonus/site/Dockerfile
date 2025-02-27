FROM debian:buster

RUN apt -y update && apt install -y nginx

COPY ./tools/index.html /var/www/html/index.html 

EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]