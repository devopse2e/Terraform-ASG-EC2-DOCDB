
# The aws_launch_template resource defines the blueprint for instances created by the ASG
resource "aws_launch_template" "backend" {
  name_prefix = "${var.name_prefix}-backend-"
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.backend_sg_id]

   # User data is now part of the launch template.
  # This script runs when a new instance is launched.
  user_data = base64encode(templatefile("${path.module}/../../scripts/backend.sh", {
    mongo_uri  = var.mongo_uri,
    port       = var.port,
    # FIX: Decode the secret before injecting it into the script from the backend.sh
    jwt_secret = var.jwt_secret
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name_prefix}-backend-instance"
    }
  }
# Ensures new launch templates are created before old ones are destroyed during an update.
  lifecycle {
    create_before_destroy = true
  }
  
}

# The aws_autoscaling_group resource manages the fleet of EC2 instances.
resource "aws_autoscaling_group" "backend" {
  name_prefix = "${var.name_prefix}-backend-asg-"

  # Connects the ASG to the launch template.
  launch_template {
    id = aws_launch_template.backend.id
    version = "$Latest"
 
  }

  # Spans the ASG across multiple Availability Zones for high availability.
  vpc_zone_identifier = var.private_subnet_ids

  # Defines the size and scaling limits of the instance fleet.
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  # Attaches instances to the Application Load Balancer's Target Group.

  target_group_arns = [var.target_group_arn]

  # Best Practice: Uses the load balancer's health checks to determine instance health.

  health_check_type = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-backend-asg-instance"
    propagate_at_launch = true
  }
  
  # Enables zero-downtime updates for the ASG itself.
  lifecycle {
    create_before_destroy = true
  }
}