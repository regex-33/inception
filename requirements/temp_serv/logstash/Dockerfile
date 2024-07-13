FROM debian:buster

# Install packages with Logstash dependencies

RUN apt-get update && apt-get install wget curl -y

COPY ./tools/logstash.sh /tmp/logstash.sh

# Download Logstash

ENTRYPOINT [ "sh", "/tmp/logstash.sh" ]