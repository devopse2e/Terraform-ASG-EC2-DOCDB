output "autoscaling_group_name" {
    description = "ASG Named for backend"
    value = aws_autoscaling_group.frontend.name
  
}
output "launch_template_id" {
    description = "frontend asg launch template id"
    value = aws_launch_template.frontend.id
  
}