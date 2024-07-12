# install kibana

apt update && apt install kibana -y

systemctl enable kibana
systemctl start kibana

# Configure Kibana to listen on all interfaces
sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/g' /etc/kibana/kibana.yml

# set the elasticsearch url

sed -i 's/#elasticsearch.hosts: \["http:\/\/localhost:9200"\]/elasticsearch.hosts: \["http:\/\/elasticsearch:9200"\]/g' /etc/kibana/kibana.yml

systemctl restart kibana
