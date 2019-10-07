data "aws_iam_role" "nodes" {
  name = "nodes.cluster-api-provider-aws.sigs.k8s.io"
}

data "aws_partition" "current" {}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = "${data.aws_iam_role.nodes.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_policy" "policy" {
  name        = "${var.name}"
  description = "The Amazon VPC CNI requires this IAM policy, used by Local IP Address Manager (L-IPAM)"

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

resource "aws_security_group" "sg" {
  name   = "${var.name}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  tags = {
    Name = "${var.name}"
  }
}