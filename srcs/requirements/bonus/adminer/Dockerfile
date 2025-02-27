FROM debian:buster


RUN apt-get update && apt-get install wget -y

COPY ./tools/adminer.sh /tmp/adminer.sh

RUN chmod +x /tmp/adminer.sh 

CMD [ "/tmp/adminer.sh" ]