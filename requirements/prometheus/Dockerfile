# Use a base image
FROM debian:buster

# Set environment variables
ENV PROMETHEUS_VERSION 2.53.1

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget tar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Prometheus
RUN wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz && \
    tar xvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz -C /tmp && \
    mv /tmp/prometheus-${PROMETHEUS_VERSION}.linux-amd64 /etc/prometheus && \
    rm prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

# Set the working directory
WORKDIR /etc/prometheus

# Expose the Prometheus port
EXPOSE 9090

# Command to run Prometheus
CMD ["./prometheus", "--config.file=/etc/prometheus/prometheus.yml", "--storage.tsdb.path=/prometheus", "--web.console.libraries=/etc/prometheus/console_libraries", "--web.console.templates=/etc/prometheus/consoles"]


# FROM debian:buster
# RUN apt-get update && apt-get install -y wget

# COPY ./tools/prometheus.sh /tmp/prometheus.sh

# ENTRYPOINT [ "sh", "/tmp/prometheus.sh" ]