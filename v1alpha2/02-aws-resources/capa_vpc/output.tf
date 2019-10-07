output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "private_subnet_ids" {
  value = [
    for subnet in aws_subnet.private:
    subnet.id
  ]
}

output "private_route_table_ids" {
  value = [
    for route_table in aws_route_table.private:
    route_table.id
  ]
}

output "public_subnet_ids" {
  value = [
    for subnet in aws_subnet.public:
    subnet.id
  ]
}
