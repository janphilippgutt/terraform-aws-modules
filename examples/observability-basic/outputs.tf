output "public_ip" {
  value       = module.observability.public_ip # ensure ec2 module exposes public_ip output, else use aws_instance.this.public_ip
  description = "Public IP of the observability EC2 instance (Prometheus/Grafana)"
}
