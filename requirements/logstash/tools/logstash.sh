apt-get install logstash -y

# config /etc/logstash/02-beats-input.conf

cat <<EOF > /etc/logstash/02-beats-input.conf
input {
  beats {
    port => 5044
  }
}
EOF

# config /etc/logstash/30-elasticsearch-output.conf

cat <<EOF > /etc/logstash/30-elasticsearch-output.conf
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

/usr/share/logstash/bin/logstash --path.settings /etc/logstash -t

systemctl start logstash
systemctl enable logstash