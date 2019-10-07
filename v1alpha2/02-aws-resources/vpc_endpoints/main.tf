data "aws_region" "current" {}

resource "aws_vpc_endpoint" "ecr_api" {
  security_group_ids = "${var.security_group_ids}"
  service_name       = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  subnet_ids         = "${var.private_subnet_ids}"
  vpc_endpoint_type  = "Interface"
  vpc_id             = "${var.vpc_id}"

  tags = {
    Name = "ecr-api-vpc-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  security_group_ids = "${var.security_group_ids}"
  service_name       = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  subnet_ids         = "${var.private_subnet_ids}"
  vpc_endpoint_type  = "Interface"
  vpc_id             = "${var.vpc_id}"

  tags = {
    Name = "ecr-dkr-vpc-endpoint"
  }
}

resource "aws_vpc_endpoint" "s3" {
  service_name    = "com.amazonaws.${data.aws_region.current.name}.s3"
  route_table_ids = "${var.route_table_ids}"
  vpc_id          = "${var.vpc_id}"

  tags = {
    Name = "s3-vpc-endpoint"
  }
}