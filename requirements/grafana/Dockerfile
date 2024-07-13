FROM debian:buster

# apt update; apt install -y wget curl vim

# cd /tmp
# apt-get install -y adduser libfontconfig1 musl
# wget https://dl.grafana.com/enterprise/release/grafana-enterprise_11.1.0_amd64.deb
# dpkg -i grafana-enterprise_11.1.0_amd64.deb

# # Directly start Grafana server in the foreground
# grafana-server -config /etc/grafana/grafana.ini -homepath /usr/share/grafana

RUN apt-get update && apt-get install -y wget curl vim adduser libfontconfig1 musl

ENV GRAFANA_VERSION 11.1.0

RUN wget https://dl.grafana.com/enterprise/release/grafana-enterprise_${GRAFANA_VERSION}_amd64.deb

RUN dpkg -i grafana-enterprise_${GRAFANA_VERSION}_amd64.deb

CMD ["grafana-server", "-config", "/etc/grafana/grafana.ini", "-homepath", "/usr/share/grafana"]


# RUN apt-get update && apt-get install -y wget

# COPY ./tools/grafana.sh /tmp/grafana.sh

# ENTRYPOINT [ "sh", "/tmp/grafana.sh" ]