FROM debian:buster

# Install packages with Kibana dependencies

RUN apt-get update && apt-get install wget curl -y

COPY ./tools/kibana.sh /tmp/kibana.sh

RUN export PATH=$PATH:/usr/share/kibana/bin
# Download Kibana
ENTRYPOINT [ "bash", "/tmp/kibana.sh" ]