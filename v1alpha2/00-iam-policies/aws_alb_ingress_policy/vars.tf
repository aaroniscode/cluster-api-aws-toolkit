variable "alb_iam_policy_name" {
  default = "k8s-aws-alb-ingress"
  description = "name of the IAM policy"
}

variable "iam_role" {
  description = "IAM role to attach the policy"
}