module "vpc" {
  source = "./capa_vpc"

  cluster_name               = "${var.cluster_name}"
  domain_name                = "${var.domain_name}"
  domain_name_servers        = "${var.domain_name_servers}"
  enable_custom_dhcp_options = "${var.enable_custom_dhcp_options}"
  private_subnet_numbers     = "${var.private_subnet_numbers}"
  public_subnet_numbers      = "${var.public_subnet_numbers}"
}

module "bastion" {
  source = "./capa_bastion"

  cluster_name = "${var.cluster_name}"
  key_pair     = "${var.key_pair}"
  subnet_id    = "${module.vpc.public_subnet_ids[0]}"
  vpc_id       = "${module.vpc.vpc_id}"
}

module "amazon_vpc_cni" {
  source = "./amazon_vpc_cni"

  vpc_id = "${module.vpc.vpc_id}"
}

module "aws_alb_ingress" {
  source = "./aws_alb_ingress"
}

module "vpc_endpoints" {
  source = "./vpc_endpoints"

  private_subnet_ids = "${module.vpc.private_subnet_ids}"
  route_table_ids    = "${module.vpc.private_route_table_ids}"
  security_group_ids = "${module.bastion.security_group_ids}"
  vpc_id             = "${module.vpc.vpc_id}"
}

locals {
  security_group_ids = concat(
    "${module.amazon_vpc_cni.security_group_ids}",
    "${module.bastion.security_group_ids}"
  )
}

module "k8s_auto_tfvars" {
  source = "./k8s_auto_tfvars"

  cluster_name       = "${var.cluster_name}"
  key_pair           = "${var.key_pair}"
  private_subnet_ids = "${module.vpc.private_subnet_ids}"
  public_subnet_ids  = "${module.vpc.public_subnet_ids}"
  security_group_ids = "${local.security_group_ids}"
  vpc_id             = "${module.vpc.vpc_id}"
}