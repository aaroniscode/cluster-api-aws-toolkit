# This is a workaround to disable a module because Terraform does not yet
# offer an official a way to disable a module.
#
# An open issue for module count feature is expected in a future v.0.12 release
# https://github.com/hashicorp/terraform/issues/953
# https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each

variable cluster_name {default=""}
variable private_subnet_ids {default=""}
variable route_table_ids {default=""}
variable security_group_ids {default=""}
variable vpc_id {default=""}