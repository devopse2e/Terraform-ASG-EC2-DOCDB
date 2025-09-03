

variable "mongo_instance_class" {
    description = "instance class for mongodoc db"
    type =string
  
}
variable "private_subnet_ids" {
    description = "private subnet id to access the ec2"
    type = list(string)
  
}
variable "mongo_username" {
    description = "username for the mongo doc db"
    sensitive = false
    type = string
  
}
variable "mongo_password" {
    description = "password for the mongo doc db"
    sensitive = true
    type = string
  
}

variable "mongodoc_sg_id" {
    description = "sg id for the ec2"
    type = string
  
}
variable "name_prefix" {
  description = "Prefix for naming SGs"
  type        = string
}