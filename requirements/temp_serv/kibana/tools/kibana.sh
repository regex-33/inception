# Install necessary tools for handling GPG keys
apt-get update && apt-get install -y gnupg2 wget curl sudo

# Add the Elastic package source GPG key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -

# Add the Elastic package source
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list

# Update package lists and install Kibana
apt-get update && apt-get install -y kibana

# Configure Kibana to listen on all interfaces
sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/g' /etc/kibana/kibana.yml

# Set the Elasticsearch URL
sed -i 's/#elasticsearch.hosts: \["http:\/\/localhost:9200"\]/elasticsearch.hosts: \["http:\/\/elasticsearch:9200"\]/g' /etc/kibana/kibana.yml


# Start Kibana manually (consider using a process manager in production environments)
exec /usr/share/kibana/bin/kibana --allow-root