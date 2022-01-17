# terraform block contains settings, required providers that terraform will use to provision your infrastructure
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.65"
    }
  }

  required_version = ">= 1.0.9"
}

# plugin to create and manage your resources
provider "aws" {
  profile = "default"
  region  = "us-east-2" # ohio
}

resource "aws_instance" "master_k8s_server" {
  ami           = "ami-001089eb624938d9f"
  instance_type = "t2.micro"
  key_name      = "KeyPairForEC2TestingInstances"
  security_groups = ["${aws_security_group.K8s_cluster_sg.name}"]

  # Copies the install-K0s.sh file to /tmp/install-K0s.sh
  # provisioner "file" {
  #   source      = "install-K0s.sh"
  #   destination = "/tmp/install-K0s.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/install-K0s.sh",
  #     "sudo /tmp/install-K0s.sh"
  #   ]
  # }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:\\Users\\rafae\\.aws\\KeyPairForEC2TestingInstances.pem")
    host     =  self.public_ip
  }

  tags = {
    Name  = "control-plane-server-instance"
    Owner = "djvruio@gmail.com"
    Environment = "DEVEL"
  }
}

resource "aws_instance" "node_01" {
  ami           = "ami-001089eb624938d9f"
  instance_type = "t2.micro"
  key_name      = "KeyPairForEC2TestingInstances"
  security_groups = ["${aws_security_group.K8s_cluster_sg.name}"]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:\\Users\\rafae\\.aws\\KeyPairForEC2TestingInstances.pem")
    host     =  self.public_ip
  }
  
  tags = {
    Name  = "node-01-server-instance"
    Owner = "djvruio@gmail.com"
    Environment = "DEVEL"
  }
}

resource "aws_security_group" "K8s_cluster_sg" {
  name = "K8s-cluster-sg"

  ingress {
    description = "Access to SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "Access to HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access to Kubernetes API"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access to ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}