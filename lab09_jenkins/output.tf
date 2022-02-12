output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.jenkins_master_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.jenkins_master_server.public_ip
}

output "instance_public_dns" {
  description = "Public IPV4 DNS of the EC2 instance"
  value       = aws_instance.jenkins_master_server.public_dns
}