output "internal_alb_arn" {
    description = "internal alb arn"
    value = aws_lb.internal_alb.arn
  
}
output "internal_alb_dns_name" {
    description = "internal alb dns name"
    value = aws_lb.internal_alb.dns_name
  
}
output "internal_alb_backend_tg_arn" {
    description = "internal alb backend tg arn"
    value = aws_lb_target_group.backend_tg.arn
  
}