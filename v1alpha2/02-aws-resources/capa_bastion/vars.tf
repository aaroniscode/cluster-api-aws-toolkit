variable "cluster_name" {
  description = "name of the cluster"
}

variable "key_pair" {
  default = "default"
  description = "AWS key pair"
}

variable "instance_type" {
  default = "t3.micro"
  description = "bastion instance type"
}

variable "subnet_id" {
  description = "subnet id of a public subnet to attach the bastion host"
}

variable "vpc_id" {
  description = "vpc id"
}