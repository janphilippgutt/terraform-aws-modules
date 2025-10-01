#!/bin/bash
set -eux   # Exit on error, print each command, treat unset variables as error

# -----------------------------
# 1) Install Docker (Amazon Linux or Ubuntu)
# -----------------------------
if command -v dnf >/dev/null 2>&1; then
  # Amazon Linux
  dnf -y install docker
elif command -v apt-get >/dev/null 2>&1; then
  # Ubuntu
  apt-get update
  apt-get -y install docker.io
else
  echo "Unsupported distro: no apt-get or dnf" >&2
  exit 1
fi

# Enable Docker to start on boot and start it now
systemctl enable --now docker

# -----------------------------
# 2) Create Prometheus config
# -----------------------------
mkdir -p /opt/prometheus
cat > /opt/prometheus/prometheus.yml <<'EOF'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']
EOF

# -----------------------------
# 3) Start Node Exporter (metrics for host)
# -----------------------------
docker run -d --restart unless-stopped \
  --name node_exporter \
  -p 9100:9100 \
  prom/node-exporter:latest

# -----------------------------
# 4) Start Prometheus
# -----------------------------
docker run -d --restart unless-stopped \
  --name prometheus \
  --network host \
  -v /opt/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus:latest --config.file=/etc/prometheus/prometheus.yml

# -----------------------------
# 5) Start Grafana
# -----------------------------
docker run -d --restart unless-stopped \
  --name grafana \
  --network host \
  grafana/grafana-oss:latest
