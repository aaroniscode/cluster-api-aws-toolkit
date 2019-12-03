data "aws_partition" "current" {}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each = toset(var.iam_roles)

  role       = "${each.key}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_policy" "policy" {
  name        = "${var.iam_policy_name}"
  description = "Policy required by Amazon VPC CNI, used by Local IP Address Manager (L-IPAM)"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:AttachNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DetachNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeInstances",
        "ec2:ModifyNetworkInterfaceAttribute",
        "ec2:AssignPrivateIpAddresses",
        "ec2:UnassignPrivateIpAddresses"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "ec2:CreateTags",
      "Resource": "arn:${data.aws_partition.current.partition}:ec2:*:*:network-interface/*"
    }
  ]
}
EOF
}