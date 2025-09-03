resource "aws_instance" "jumpbox_instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.subnet_id
    associate_public_ip_address = true
    vpc_security_group_ids = [var.jump_box_sg_id]
    user_data_base64 =  base64encode(file("${path.module}/../../scripts/jumpbox.sh"))

    tags = {
      Name = "${var.name_prefix}-jumpbox"
    }

connection  {

    type = "ssh"
    host = aws_instance.jumpbox_instance.public_ip
    user = "ec2-user"
    private_key = file(var.ssh_private_key_path)

  }
provisioner "file" {
  source = "${path.module}/../../bastion_key.pem"
  destination = "/home/ec2-user/.ssh/bastion_key.pem"


}

provisioner "remote-exec" {
  inline = [
    "sudo chmod 600 /home/ec2-user/.ssh/bastion_key.pem",
    "sudo chown ec2-user:ec2-user /home/ec2-user/.ssh/bastion_key.pem"
  ]
  
}

}