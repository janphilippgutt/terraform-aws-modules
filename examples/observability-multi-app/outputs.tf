output "observability_ec2_public_ip" {
  value       = module.observability.public_ip
  description = "Public IP of the observability EC2 instance (Prometheus/Grafana)"
}

output "observability_ec2_private_ip" {
  value       = module.observability.private_ip
  description = "Private IP of the observability EC2 instance (Prometheus/Grafana)"
}

output "app_server_private_ips" {
  value = local.app_server_ips
  description = "List of private IPs of applied app servers"
}