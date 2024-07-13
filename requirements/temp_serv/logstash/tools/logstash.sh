# Add the Elastic package repository and install Logstash
apt-get update && apt-get install -y wget gnupg
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list
apt-get update && apt-get install logstash -y

# Ensure the Logstash configuration directories exist
mkdir -p /etc/logstash/conf.d

# Configure Logstash for Beats input and Elasticsearch output
cat <<EOF > /etc/logstash/conf.d/02-beats-input.conf
input {
  beats {
    port => 5044
  }
}
EOF

cat <<EOF > /etc/logstash/conf.d/30-elasticsearch-output.conf
output {
    if [@metadata][pipeline] {
        elasticsearch {
            hosts => ["elasticsearch:9200"]
            manage_template => false
            index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
            pipeline => "%{[@metadata][pipeline]}"
        }
    } else {
        elasticsearch {
            hosts => ["elasticsearch:9200"]
            manage_template => false
            index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
        }
    }
}
EOF

# Test the Logstash configuration
exec /usr/share/logstash/bin/logstash --path.settings /etc/logstash/conf.d -t

# Start Logstash (adapted for Docker; consider using a process manager in production environments)
# /usr/share/logstash/bin/logstash --path.settings /etc/logstash/conf.d

# apt-get install logstash -y

# # config /etc/logstash/02-beats-input.conf

# cat <<EOF > /etc/logstash/02-beats-input.conf
# input {
#   beats {
#     port => 5044
#   }
# }
# EOF

# # config /etc/logstash/30-elasticsearch-output.conf

# cat <<EOF > /etc/logstash/30-elasticsearch-output.conf
# output {
#     if [@metadata][pipeline] {
#         elasticsearch {
#             hosts => ["elasticsearch:9200"]
#             manage_template => false
#             index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
#             pipeline => "%{[@metadata][pipeline]}"
#         }
#     } else {
#         elasticsearch {
#             hosts => ["elasticsearch:9200"]
#             manage_template => false
#             index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
#         }
#     }
# }
# EOF

# /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t

# systemctl start logstash
# systemctl enable logstash