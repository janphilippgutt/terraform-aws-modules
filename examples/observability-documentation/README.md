# Observability with Prometheus & Grafana

This project demonstrates an observability setup, where Prometheus is used to scrape metrics from EC2 instances. 
Grafana consumes Prometheus as Data source and visualizes metrics in dashboards.

Highlights: 

- **end-to-end** setup:
                infra bootstrapping → observability integration → visualization

- **Modular IaC** design.

- **Networking/security** management for metrics collection.

- Monitoring stack with **Prometheus + Grafana**.

- **Scaling** across multiple servers.

## ⚙️ Setup Guide ⚙️ 

### 1. Clone repo & initialize

Clone repo and choose single-app (/observabilitiy-basic) or multi-app (/observability) setup:

```
git clone https://github.com/janphilippgutt/terraform-aws-modules
cd examples/observability-basic   # or observability-multi-app
terraform init

```

### 2. Adjust variables

Create terraform.tfvars with: 

```
my_ip_cidr       = "<your-ip>/32"
ssh_public_key_path = "~/.ssh/<path-to-your-rsa.pub-file>"
```

### 3. Apply resources

```
terraform apply
```

Terraform provisions:

- VPC + subnet + route to IGW
- Security groups (restricted to your IP)
- EC2 instances (Ubuntu) with observability stack

## ✅ Access services ✅

### - **Grafana UI:** http://<observability-public-ip>:3000 (default: admin/admin)

<img width="905" height="641" alt="Image" src="https://github.com/user-attachments/assets/2c8a9852-b7cb-4bd3-bb33-48aa181806e5" />

### - **Prometheus UI:** http://<observability-public-ip>:9090/targets

<img width="1853" height="514" alt="Image" src="https://github.com/user-attachments/assets/c0eaf0e2-f54e-4602-bd3a-22e361be197c" />

### - **Connect Prometheus with Grafana**

<img width="1003" height="679" alt="Image" src="https://github.com/user-attachments/assets/3d0b1666-4793-4093-9469-0baf30a89956" />

## 🔍 Testing & Verification 🔍

### Prometheus

Check scrape targets:

```
curl http://<observability-public-ip>:9090/targets
```

All nodes (observability-node, app-server-node) should be **UP**.

### Grafana

1. Import Dashboard ID 1860 (Node Exporter Full).

2. Toggle between jobs:

- observability-node

- app-server-node (multiple nodes available under nodename).

3. Run stress tests on app servers:

```
stress-ng --cpu 2 --timeout 30s
```
### Watch CPU load in Grafana update in near real-time.

<img width="748" height="478" alt="Image" src="https://github.com/user-attachments/assets/1a29e1e8-92d9-45d9-8df6-099933331f5a" />

<img width="1524" height="773" alt="Image" src="https://github.com/user-attachments/assets/7cea3e6e-1d9a-4afa-9cf0-2b637a8d05bc" />