resource "local_file" "vpc_tfvars" {
  content  = templatefile("${path.module}/vpc.tfvars", {
    cluster_name       = "${var.cluster_name}"
    cni                = "${var.cni}"
    key_pair           = "${var.key_pair}"
    private_subnet_ids = format("%#v", "${var.private_subnet_ids}"),
    public_subnet_ids  = format("%#v", "${var.public_subnet_ids}"),
    security_group_ids = format("%#v", "${var.security_group_ids}"),
    vpc_id             = "${var.vpc_id}"
  })
  filename = "${path.root}/../03-capa-manifests/vpc.auto.tfvars"
}