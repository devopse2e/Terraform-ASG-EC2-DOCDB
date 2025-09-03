resource "aws_lb" "internal_alb" {
    name = "${var.name_prefix}-internal-alb"
    internal = true
    load_balancer_type = "application"
    security_groups = [var.internal_alb_sg_id]
    subnets = var.private_subnet_ids
    enable_deletion_protection = false

    tags = {
      Name = "${var.name_prefix}-internal-alb"
    }
  
}

resource "aws_lb_target_group" "backend_tg" {
    name = "${var.name_prefix}-backend-tg"
    port = 3001
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
      Name = "${var.name_prefix}-backend-tg"
    }
}

resource "aws_lb_listener" "internal_listener" {
    load_balancer_arn = aws_lb.internal_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.backend_tg.arn
    }
  
}

