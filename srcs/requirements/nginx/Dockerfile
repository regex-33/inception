FROM debian:buster

RUN apt -y update && apt install -y nginx && apt install openssl -y

COPY ./conf/default /tmp/default

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh 

EXPOSE 443

CMD ["/tmp/script.sh"]