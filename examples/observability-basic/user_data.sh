#!/bin/bash
set -eux

# install packages (works for Amazon Linux or Ubuntu)
if command -v dnf >/dev/null 2>&1; then
  dnf -y install docker
elif command -v apt-get >/dev/null 2>&1; then
  apt-get update
  apt-get -y install docker.io
else
  echo "Unsupported distro: no apt-get or dnf" >&2
  exit 1
fi

systemctl enable --now docker

# create prometheus config dir and file
mkdir -p /opt/prometheus
cat > /opt/prometheus/prometheus.yml <<'EOF'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']
EOF

# start node_exporter
docker run -d --restart unless-stopped --name node_exporter -p 9100:9100 prom/node-exporter:latest

# start prometheus
docker run -d --restart unless-stopped --name prometheus -p 9090:9090 \
  -v /opt/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus:latest --config.file=/etc/prometheus/prometheus.yml

# start grafana (default admin/admin)
docker run -d --restart unless-stopped --name grafana -p 3000:3000 grafana/grafana-oss:latest
