#!/bin/bash
set -eux

# install docker
if command -v apt-get >/dev/null 2>&1; then
  apt-get update -y
  apt-get install -y docker.io
elif command -v dnf >/dev/null 2>&1; then
  dnf -y install docker
fi

systemctl enable --now docker

# run node_exporter
docker run -d --restart unless-stopped --name node_exporter -p 9100:9100 prom/node-exporter:latest
