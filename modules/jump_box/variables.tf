variable "ami_id" {
    description = "ami id for the ec2"
    type = string
}
variable "instance_type" {
    description = "instance type for the ec2"
    type = string
}
variable "subnet_id" {
    description = "subnet id to access the ec2"
    type = string
  
}
variable "key_name" {
    description = "ssh key"
    sensitive = true
    type = string
  
}
variable "jump_box_sg_id" {
    description = "sg id for the ec2"
    type = string
  
}
variable "name_prefix" {
  description = "Prefix for naming SGs"
  type        = string
}

variable "ssh_private_key_path" {
    description = "ssh key path in jumpbox"
    type = string
  
}