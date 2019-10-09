variable "ami_id" {
  default = ""
}

variable "cluster_name" {
  default = "capa"
}

variable "controlplane_instance_type" {
  default = "t3.medium"
}

variable "controlplane_nodes" {
  default = ["controlplane"]
}

variable "key_pair" {
  default = "default"
}

variable "k8s_version" {
  default = "v1.15.3"
}

variable k8s_image_repository {
  default = null
}

variable "private_subnet_ids" {}

variable "public_subnet_ids" {}

variable "root_device_size" {
  default = 20
}

variable "security_group_ids" {}

variable "vpc_id" {}

variable "worker_instance_type" {
  default = "t3.medium"
}

variable "worker_nodes" {
  default = {
    "worker": 2,
  }
}