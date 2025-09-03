output "nat_gw_id" {
  value = var.create_nat ? aws_nat_gateway.nat_gw[0].id : ""
}
