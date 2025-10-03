#!/bin/bash
set -eux

# Install Docker on Ubuntu
apt-get update -y
apt-get install -y docker.io
systemctl enable --now docker

# Create Prometheus config dir
mkdir -p /opt/prometheus

# Write Prometheus config with scrape targets
cat > /opt/prometheus/prometheus.yml <<EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'observability-node'
    static_configs:
      - targets: ['localhost:9100']

  - job_name: 'app-servers'
    static_configs:
      - targets: [${app_server_ips}]
EOF

# Start node_exporter (self monitoring)
docker run -d --restart unless-stopped --name node_exporter -p 9100:9100 prom/node-exporter:latest

# Start Prometheus
docker run -d --restart unless-stopped --name prometheus -p 9090:9090 \
  --network host \
  -v /opt/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus:latest --config.file=/etc/prometheus/prometheus.yml

# Start Grafana
docker run -d --restart unless-stopped --name grafana -p 3000:3000 grafana/grafana-oss:latest
