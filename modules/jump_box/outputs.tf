output "jumpbox_instance_id" {
    description = "jumpbox ec2 id"
    value = aws_instance.jumpbox_instance.id
  
}
output "jumpbox_public_ip" {
    description = "jumpbox ec2 public ip"
    value = aws_instance.jumpbox_instance.public_ip
  
}