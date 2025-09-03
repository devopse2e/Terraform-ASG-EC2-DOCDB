variable "aws_region" {
    description = "AWS region to deploy infra"
    type = string
    default = "us-east-1"
  
}

variable "vpc_cidr" {
    description = "CIDR block for the vpc"
    type = string
    default = "10.0.0.0/16"
  
}

variable "azs" {
    description = "AZ for the aws infra"
    type = list(string)
    default = [ "us-east-1a", "us-east-1b" ]
  
}

variable "name_prefix" {
    description = "Name prefix for the resources"
    type = string
    default = "orbittasks"
  
}

variable "public_subnet_cidr" {
    description = "public subnet CIDR"
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
  
}

variable "private_subnet_cidr" {
    description = "private subnet CIDR"
    type = list(string)
    default = [ "10.0.10.0/24", "10.0.20.0/24" ]

  
}
variable "create_nat" {
  description = "Toggle for NAT Gateway creation"
  type        = bool
  default     = false
}

variable "allowed_ssh_cidr" {
    description = "allowed ssh cidr to access jump box"
    type = string
    default = "0.0.0.0/0"
  
}
variable "ami_id" {
    description = "ami id for the ec2"
    type = string
    default = "ami-08a6efd148b1f7504"
}
variable "instance_type" {
    description = "instance type for the ec2"
    type = string
    default = "t3.micro"
}
variable "key_name" {
    description = "ssh key"
    type = string
    sensitive = true
    default = "bastion_key"
  
}
variable "ssh_private_key_path" {
    description = "ssh key path in jumpbox"
    type = string
  
}


variable "desired_capacity" {
  description = "The desired number of instances for the ASG to maintain"
  type        = number
}

variable "min_size" {
  description = "The minimum number of instances the ASG can scale down to"
  type        = number
}

variable "max_size" {
  description = "The maximum number of instances the ASG can scale up to"
  type        = number
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
variable "mongodoc_instance_class" {
    description = "instance class for mongodoc db"
    type =string
  
}