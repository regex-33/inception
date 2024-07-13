# Add the Elastic package repository and install Filebeat
apt-get update && apt-get install -y wget gnupg apt-transport-https sudo lsb-release ca-certificates  curl
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list
apt-get update && apt-get install filebeat -y

# Ensure the Filebeat configuration directory exists
mkdir -p /etc/filebeat

# Configure Filebeat
cat <<EOF > /etc/filebeat/filebeat.yml
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/nginx/access.log
    - /var/log/nginx/error.log
  fields:
    type: nginx
  fields_under_root: true

- type: log
  enabled: true
  paths:
    - /var/log/mysql/error.log
  fields:
    type: mysql
  fields_under_root: true

output.logstash:
  hosts: ["logstash:5044"]
EOF

# Enable and configure modules
filebeat modules enable system
filebeat setup --pipelines --modules system
filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["elasticsearch:9200"]'
filebeat setup -E output.logstash.enabled=false -E output.elasticsearch.hosts=['elasticsearch:9200'] -E setup.kibana.host=kibana:5601

# Start Filebeat (adapted for Docker; consider using a process manager in production environments)
exec filebeat -e
# apt update && apt install filebeat -y

# # config /etc/filebeat/filebeat.yml

# cat <<EOF > /etc/filebeat/filebeat.yml

# filebeat.inputs:
# - type: log
#   enabled: true
#   paths:
#     - /var/log/nginx/access.log
#     - /var/log/nginx/error.log
#   fields:
#     type: nginx
#   fields_under_root: true

# - type: log
#     enabled: true
#     paths:
#         - /var/log/mysql/error.log
#     fields:
#         type: mysql
#     fields_under_root: true

# output.logstash:
#     hosts: ["logstash:5044"]

# EOF

# filebeat modules enable system

# filebeat modules list

# filebeat setup --pipelines --modules system

# filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["elasticsearch:9200"]' 


# filebeat setup -E output.logstash.enabled=false -E output.elasticsearch.hosts=['elasticsearch:9200'] -E setup.kibana.host=kibana:5601   

# filebeat modules enable system

# systemctl enable filebeat

# systemctl start filebeat

