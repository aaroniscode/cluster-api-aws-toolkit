output "security_group_ids" {
  value = ["${aws_security_group.bastion_to_nodes.id}"]
}