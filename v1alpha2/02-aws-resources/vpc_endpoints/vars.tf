variable "private_subnet_ids" {}

variable "security_group_ids" {}

variable "vpc_id" {
  description = "vpc id"
}

variable "route_table_ids" {
  description = "ids of route tables to connect to vpc s3 endpoint"
}