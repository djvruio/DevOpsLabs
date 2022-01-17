output "master_k8s_server_instance_id" {
  description = "ID of the EC2 master K8s server instance (controller + worker)"
  value       = aws_instance.master_k8s_server.id
}

output "master_k8s_server_instance_public_ip" {
  description = "Public IP address of the EC2 master K8s server instance (controller + worker)"
  value       = aws_instance.master_k8s_server.public_ip
}

output "node_01_instance_id" {
  description = "ID of the EC2 node_01 instance (worker)"
  value       = aws_instance.node_01.id
}

output "node_01_instance_public_ip" {
  description = "Public IP address of the EC2 node_01 instance (worker)"
  value       = aws_instance.node_01.public_ip
}