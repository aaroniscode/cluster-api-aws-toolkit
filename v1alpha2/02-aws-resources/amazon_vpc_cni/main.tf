locals {
  sg_name = "${var.cluster_name}-amazon-vpc-cni"
}

resource "aws_security_group" "sg" {
  name   = "${local.sg_name}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  tags = {
    Name = "${local.sg_name}"
  }
}