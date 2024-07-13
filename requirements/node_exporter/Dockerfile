# Use a base image
FROM debian:buster

# Set environment variables for Node Exporter version
ENV NODE_EXPORTER_VERSION 1.8.1

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget tar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Node Exporter
RUN wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz && \
    tar xvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -C /tmp && \
    mv /tmp/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin && \
    rm node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz

# Expose the Node Exporter port
EXPOSE 9100

# Command to run Node Exporter
CMD ["/usr/local/bin/node_exporter"]