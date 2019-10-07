variable "cluster_name" {
  default     = "capa"
  description = "name of the cluster"
}

variable "domain_name" {
  default = "example.com"
  description = "domain name suffix"
}

variable "domain_name_servers" {
  default     = ["AmazonProvidedDNS"]
  description = "dns servers"
}

variable "enable_custom_dhcp_options" {
  default     = false
  description = "use only if setting domain_name_server or domain_name"
  type        = bool
}

variable "private_subnet_numbers" {
  default = {
    "a" = 0
  }
  description = "Map from availability zone to the subnet number"
}

variable "public_subnet_numbers" {
  default = {
    "a" = 1
  }
  description = "Map from availability zone to the subnet number"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "vpc cidr"
}
