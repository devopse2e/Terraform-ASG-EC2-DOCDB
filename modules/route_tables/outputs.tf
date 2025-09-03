output "public_route_table_id" {
    description = "public route table id"
    value = aws_route_table.public.id  
}

output "private_route_table_ids" {
    description = "private route table id"
    value = aws_route_table.private[*].id  
}