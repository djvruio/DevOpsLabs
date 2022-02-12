variable "instance_name" {
  description = "Value of the Name tag for the EC2 Jenkins Master Instance for Testing purposes"
  type        = string
  default     = "Jenkins-Tester-Instance"
}

variable "owner" {
  description = "Value of the Owner"
  type        = string
  default     = "djvruio@gmail.com"
}

variable "project" {
  type    = string
  default = "jenkins-research"
}

variable "environment" {
  type    = string
  default = "TEST"
}