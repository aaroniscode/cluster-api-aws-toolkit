output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "private_subnet_ids" {
  value = "${module.vpc.private_subnet_ids}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

output "security_group_ids" {
  value = "${local.security_group_ids}"
}