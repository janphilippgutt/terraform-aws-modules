output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IP of the EC2 instance"
}

output "private_ip" {
  value = aws_instance.this.private_ip
  description = "Private IP of the EC2 instance"
}