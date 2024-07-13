FROM debian:buster

# Install packages with Filebeat dependencies

RUN  apt-get update && apt-get install wget -y

COPY ./tools/filebeat.sh /tmp/filebeat.sh

# Download Filebeat
ENTRYPOINT [ "sh", "/tmp/filebeat.sh" ]