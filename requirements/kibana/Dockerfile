FROM debian:buster

# Install packages with Kibana dependencies

RUN apt-get update && apt-get install wget curl -y

COPY ./tools/kibana.sh /tmp/kibana.sh

# Download Kibana
ENTRYPOINT [ "sh", "/tmp/kibana.sh" ]