output "public_ip" {
  value = aws_instance.this.public_ip
}

output "security_group_id" {
  value = var.security_group_ids[0]
}