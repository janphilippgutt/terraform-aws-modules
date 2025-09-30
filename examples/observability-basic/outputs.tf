output "public_ip" {
  value = module.observability.public_ip  # ensure ec2 module exposes public_ip output, else use aws_instance.this.public_ip
}
