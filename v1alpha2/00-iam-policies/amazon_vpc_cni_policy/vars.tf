variable "iam_policy_name" {
  default = "k8s-amazon-vpc-cni"
  description = "name of the IAM policy"
}

variable "iam_roles" {
  description = "IAM role to attach the policy"
  type = list(string)
}