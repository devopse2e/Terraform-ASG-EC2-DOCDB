output "internet_alb_arn" {
    description = "internet alb arn"
    value = aws_lb.internet_alb.arn
  
}
output "internet_alb_dns_name" {
    description = "internet alb dns name"
    value = aws_lb.internet_alb.dns_name
  
}
output "internet_alb_frontend_tg_arn" {
    description = "internet alb frontend tg arn"
    value = aws_lb_target_group.frontend_tg.arn
  
}