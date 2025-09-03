
resource "aws_launch_template" "frontend" {
  name_prefix = "${var.name_prefix}-frontend-"
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.frontend_sg_id]

  user_data = base64encode(templatefile("${path.module}/../../scripts/frontend.sh", {
    react_app_api_url = var.react_app_api_url,
    backend_url = var.backend_url
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name_prefix}-frontend-instance"
    }
  }
  # Ensures new launch templates are created before old ones are destroyed during an update.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "frontend" {
  name_prefix = "${var.name_prefix}-frontend-asg-"

  # Connects the ASG to the launch template.
  launch_template {
    id = aws_launch_template.frontend.id
    version = "$Latest"
  }

  # Spans the ASG across multiple Availability Zones for high availability.
  vpc_zone_identifier = var.private_subnet_ids

  # Attaches instances to the Application Load Balancer's Target Group.

  target_group_arns = [var.target_group_arn]

  # Defines the size and scaling limits of the instance fleet.
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  # Best Practice: Uses the load balancer's health checks to determine instance health.

  health_check_type = "ELB"
  health_check_grace_period = 300

  tag {
    key = "Name"
    value = "${var.name_prefix}-frontend-asg-instance"
    propagate_at_launch = true
  }

  # Enables zero-downtime updates for the ASG itself.
  lifecycle {
    create_before_destroy = true
  }

  
}
