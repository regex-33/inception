# install elasticsearch

cd /tmp
curl -fsSL  https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-linux-x86_64.tar.gz -o elasticsearch.tar.gz
tar -xzf elasticsearch.tar.gz
mv elasticsearch-7.10.2 /usr/share/elasticsearch
rm -rf elasticsearch.tar.gz

# Create a non-root user for Elasticsearch
useradd -r -d /usr/share/elasticsearch -s /bin/false elasticsearch

# Change ownership of the Elasticsearch directory
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch

# edit the configuration file
sed -i 's/#network.host: 192.168.0.1/network.host: localhost/g' /usr/share/elasticsearch/config/elasticsearch.yml

# run elasticsearch as non-root user
sudo -u elasticsearch /usr/share/elasticsearch/bin/elasticsearch