terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.65"
    }
  }

  required_version = ">= 1.0.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1" # virginia
}

resource "aws_instance" "jenkins_master_server" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.small" #vCPU 2 - GiB 4
  key_name      = "KeyPairForEC2TestingInstancesVirginia"

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 8
    volume_type = "gp2"
  }

  security_groups = ["${aws_security_group.jenkins_sg.name}"]

  # Copies the install-stuffjava-jenkins.sh file to /tmp/install-java-jenkins.sh
  provisioner "file" {
    source      = "install-java-jenkins.sh"
    destination = "/tmp/install-java-jenkins.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-java-jenkins.sh",
      "sudo /tmp/install-java-jenkins.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:\\Users\\rafae\\.aws\\KeyPairForEC2TestingInstancesVirginia.pem")
    host        = self.public_ip
  }

  tags = {
    Name        = var.instance_name
    Owner       = var.owner
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_security_group" "jenkins_sg" {
  name = "jenkins-sg"

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
    description = "Access to HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Jenkins listen port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Jenkins listen port 8081"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #https://www.jenkins.io/doc/book/installing/linux/
}
