variable "vpc_id" {
    description = "VPC ID"
    type = string
}
variable "allowed_ssh_cidr" {
    description = "allowed ssh cidr to access jump box"
    type = string
    default = "0.0.0.0/0"
  
}
variable "name_prefix" {
  description = "Prefix for naming SGs"
  type        = string
}