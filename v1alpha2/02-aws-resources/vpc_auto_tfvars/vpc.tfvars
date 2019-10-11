# This is an automated file created by the terraform in 02-aws-resources
# to be used as input for the terraform in 03-k8s-manifests
cluster_name       = "${cluster_name}"
cni                = "${cni}"
key_pair           = "${key_pair}"
private_subnet_ids = ${private_subnet_ids}
public_subnet_ids  = ${public_subnet_ids}
security_group_ids = ${security_group_ids}
vpc_id             = "${vpc_id}"