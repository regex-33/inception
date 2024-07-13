apt-get update; apt-get install -y wget curl vim
# Install Prometheus
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.53.1/prometheus-2.53.1.linux-amd64.tar.gz
tar -xvzf prometheus-2.53.1.linux-amd64.tar.gz
mv prometheus-2.53.1.linux-amd64 /etc/prometheus

# Install Node Exporter
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz
tar -xvzf node_exporter-1.8.1.linux-amd64.tar.gz
mv node_exporter-1.8.1.linux-amd64 /etc/node_exporter

# Setup Prometheus configuration
rm -rf /etc/prometheus/prometheus.yml
cat <<EOF > /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
EOF

# Run Prometheus
nohup /etc/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml > /var/log/prometheus.log 2>&1 &

# Run Node Exporter
nohup /etc/node_exporter/node_exporter > /var/log/node_exporter.log 2>&1 &


# apt-get update; apt-get install -y wget curl vim
# #Install prometheus
# cd /tmp
# wget https://github.com/prometheus/prometheus/releases/download/v2.53.1/prometheus-2.53.1.linux-amd64.tar.gz
# tar -xvzf prometheus-2.53.1.linux-amd64.tar.gz
# mv prometheus-2.53.1.linux-amd64 /etc/prometheus


# ## edit prometheus configuration
# cat <<EOF > /etc/systemd/system/prometheus.service
# [Unit]
# Description=Prometheus
# Wants=network-online.target
# After=network-online.target
# [Service]
# ExecStart=/etc/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml
# Restart=always
# [Install]
# WantedBy=multi-user.target

# EOF

# systemctl daemon-reload
# systemctl restart prometheus
# systemctl enable prometheus


# #Install node_exporter

# cd /tmp
# wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz
# tar -xvzf node_exporter-1.8.1.linux-amd64.tar.gz
# mv node_exporter-1.8.1.linux-amd64 /etc/node_exporter


# cat <<EOF > /etc/systemd/system/node_exporter.service
# [Unit]
# Description=Node Exporter
# Wants=network-online.target
# After=network-online.target
# [Service]
# ExecStart=/etc/node_exporter/node_exporter
# Restart=always
# [Install]
# WantedBy=multi-user.target

# EOF

# systemctl daemon-reload
# systemctl restart node_exporter
# systemctl enable node_exporter

# rm -rf /etc/prometheus/prometheus.yml

# cat <<EOF > /etc/prometheus/prometheus.yml
# global:
#   scrape_interval: 15s
#   evaluation_interval: 15s
# scrape_configs:
#     - job_name: 'prometheus'
#         static_configs:
#         - targets: ['prometheus:9090']
#     - job_name: 'node_exporter'
#         static_configs:
#         - targets: ['node_exporter:9100']

# EOF

# systemctl restart prometheus
# systemctl restart node_exporter



