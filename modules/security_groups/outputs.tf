output "jumpbox_sg_id" {
    value = aws_security_group.jump_box_sg.id
  
}

output "internet_alb_sg_id" {
    value = aws_security_group.internet_alb_sg.id
  
}

output "frontend_sg_id" {
    value = aws_security_group.frontend_sg.id
  
}

output "internal_alb_sg_id" {
    value = aws_security_group.internal_alb_sg.id
  
}

output "backend_sg_id" {
    value = aws_security_group.backend_sg.id
  
}

output "mongodoc_sg_id" {
    value = aws_security_group.mongodoc_sg.id
  
}