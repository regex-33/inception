FROM alpine:3.13

RUN	apk update && apk upgrade && apk add --no-cache \
        mariadb \
        mariadb-client

COPY tools/script.sh /tmp/script.sh

RUN  chmod +x /tmp/script.sh

CMD [ "/tmp/script.sh"]