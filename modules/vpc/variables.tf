variable "vpc_cidr" {
    description = "CIDR block for the vpc"
    type = string
}

variable "azs" {
    description = "AZ for the aws infra"
    type = list(string)
}

variable "name_prefix" {
    description = "Name prefix for resources"
    type = string
}

variable "public_subnet_cidr" {
    description = "public subnet CIDR"
    type = list(string)
}

variable "private_subnet_cidr" {
    description = "private subnet CIDR"
    type = list(string)
}