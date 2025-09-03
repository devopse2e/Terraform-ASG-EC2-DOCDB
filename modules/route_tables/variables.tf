variable "vpc_id" {
    description = "VPC ID"
    type = string
}
variable "azs" {
    description = "AZ for the aws infra"
    type = list(string)
}
variable "igw_id" {
    description = "IGW ID"
    type = string
}

variable "name_prefix" {
    description = "Name prefix for resources"
    type = string
}

variable "public_subnet_id" {
    description = "public subnet ID"
    type = list(string)
}

variable "private_subnet_id" {
    description = "private subnet ID"
    type = list(string)
}

variable "nat_gw_id" {
    description = "nat gw id"
    type = string
  
}