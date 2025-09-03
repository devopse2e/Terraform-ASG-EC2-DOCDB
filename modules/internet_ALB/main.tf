resource "aws_lb" "internet_alb" {
    name = "${var.name_prefix}-internet-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.internet_alb_sg_id]
    subnets = var.public_subnet_ids
    enable_deletion_protection = false

    tags = {
      Name = "${var.name_prefix}-internet-alb"
    }
  
}

resource "aws_lb_target_group" "frontend_tg" {
    name = "${var.name_prefix}-frontend-tg"
    port = 3000
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      healthy_threshold = 3
      unhealthy_threshold = 5
      timeout = 15
      interval = 60
      path = "/"
      matcher = "200"
    }

    tags = {
      Name = "${var.name_prefix}-frontend-tg"
    }
}

resource "aws_lb_listener" "http_listener" {
    load_balancer_arn = aws_lb.internet_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.frontend_tg.arn
    }
  
}

