FROM debian:buster

# Install packages with Elasticsearch dependencies

RUN apt-get update && apt-get install wget curl -y

COPY ./tools/elasticsearch.sh /tmp/elasticsearch.sh

# Download Elasticsearch
ENTRYPOINT [ "sh", "/tmp/elasticsearch.sh" ]