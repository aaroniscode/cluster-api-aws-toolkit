locals {
  controlplane_policy_name ="control-plane.cluster-api-provider-aws.sigs.k8s.io"
  node_policy_name = "nodes.cluster-api-provider-aws.sigs.k8s.io"
}

module "amazon_vpc_cni_policy" {
  source = "./amazon_vpc_cni_policy"

  iam_roles = [
    "${local.controlplane_policy_name}",
    "${local.node_policy_name}",
  ]
}

module "aws_alb_ingress_policy" {
  source = "./aws_alb_ingress_policy"

  iam_role = "${local.node_policy_name}"
}

module "image_builder_role" {
  source = "./image_builder_role"
}