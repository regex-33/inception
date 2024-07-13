apt update; apt install -y wget curl vim

cd /tmp
apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_11.1.0_amd64.deb
dpkg -i grafana-enterprise_11.1.0_amd64.deb

# Directly start Grafana server in the foreground
grafana-server -config /etc/grafana/grafana.ini -homepath /usr/share/grafana
