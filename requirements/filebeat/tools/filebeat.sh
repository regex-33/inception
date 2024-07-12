apt update && apt install filebeat -y

# config /etc/filebeat/filebeat.yml

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

filebeat modules enable system

filebeat modules list

filebeat setup --pipelines --modules system

filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["elasticsearch:9200"]' 


filebeat setup -E output.logstash.enabled=false -E output.elasticsearch.hosts=['elasticsearch:9200'] -E setup.kibana.host=kibana:5601   

filebeat modules enable system

systemctl enable filebeat

systemctl start filebeat

