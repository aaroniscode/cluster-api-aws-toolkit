resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_vpc_dhcp_options" "dopt" {
  count = var.enable_custom_dhcp_options ? 1 : 0

  domain_name          = var.domain_name
  domain_name_servers  = var.domain_name_servers

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_vpc_dhcp_options_association" "dopt_assoc" {
  count = var.enable_custom_dhcp_options ? 1 : 0

  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dopt[0].id
}

data "aws_region" "current" {}

resource "aws_subnet" "private" {
  for_each = var.private_subnet_numbers

  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${data.aws_region.current.name}${each.key}"
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, each.value)

  tags = {
    Name = "${var.cluster_name}-private-${each.key}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = ""
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnet_numbers

  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${data.aws_region.current.name}${each.key}"
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, each.value)

  tags = {
    Name = "${var.cluster_name}-public-${each.key}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = ""
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_eip" "nat" {
  for_each = var.public_subnet_numbers

  vpc = true

  tags = {
    Name = "${var.cluster_name}-nat-${each.key}"
  }
}

resource "aws_nat_gateway" "nat" {
  for_each = var.public_subnet_numbers

  allocation_id = aws_eip.nat[each.key].id
  subnet_id = aws_subnet.public[each.key].id

  tags = {
    Name = "${var.cluster_name}-nat-${each.key}"
  }
}

resource "aws_route_table" "private" {
  for_each = var.private_subnet_numbers

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[each.key].id
  }

  tags = {
    Name = "${var.cluster_name}-private-${each.key}"
  }
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnet_numbers

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_route_table" "public" {
  for_each = var.public_subnet_numbers

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.cluster_name}-public-${each.key}"
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnet_numbers

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}