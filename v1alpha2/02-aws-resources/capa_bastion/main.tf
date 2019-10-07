data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
 }
}

locals {
  bastion_name = "${var.cluster_name}-bastion-byo"
}

resource "aws_instance" "bastion" {
  ami                         = "${data.aws_ami.amazon-linux-2.id}"
  associate_public_ip_address = true
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_pair}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]

  tags = {
    Name = "${local.bastion_name}"
  }
}

resource "aws_security_group" "bastion" {
  name        = "${local.bastion_name}"
  description = "Allow SSH from Internet to bastion host"
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.bastion_name}"
  }
}

resource "aws_security_group" "bastion_to_nodes" {
  name   = "${local.bastion_name}-to-nodes"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = ["${aws_security_group.bastion.id}"]
  }

  tags = {
    Name = "${local.bastion_name}-to-nodes"
  }
}