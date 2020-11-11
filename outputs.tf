# Outputs.tf
output "instance_id" {
  description = "Instance ID of the instance"
  value       = aws_instance.barn-instance.id
}

output "instance_IP" {
  description = "Public IP of the instance"
  value       = aws_instance.barn-instance.public_ip
}
