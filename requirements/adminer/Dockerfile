FROM debian:buster


RUN apt-get update && apt-get install wget -y

COPY ./tools/adminer.sh /tmp/adminer.sh
# Download Adminer
ENTRYPOINT [ "sh", "/tmp/adminer.sh" ]