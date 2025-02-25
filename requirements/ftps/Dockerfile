FROM debian:buster

RUN apt-get update && apt-get install -y \
    vsftpd

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh


EXPOSE 21

# CMD ["/tmp/script.sh"]
ENTRYPOINT [ "sh" , "/tmp/script.sh" ]