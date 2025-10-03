output "observability_ec2_public_ip" {
  value       = module.observability.public_ip # ensure ec2 module exposes public_ip output, else use aws_instance.this.public_ip
  description = "Public IP of the observability EC2 instance (Prometheus/Grafana)"
}

output "app_server1_public_ip" {
  value       = module.app_server1.public_ip
  description = "Public IP of the app_server1 EC2 instance to be scraped with Prometheus"
}

output "app_server2_public_ip" {
  value       = module.app_server2.public_ip
  description = "Public IP of the app_server2 EC2 instance to be scraped with Prometheus"
}