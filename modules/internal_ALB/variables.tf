variable "name_prefix" {
  description = "Prefix for naming SGs"
  type        = string
}
variable "vpc_id" {
    description = "VPC ID"
    type = string
}
variable "private_subnet_ids" {
    description = "private subnet ids for internet alb"
    type = list(string)
  
}
variable "internal_alb_sg_id" {
  description = "Security Group ID for ALB"
  type        = string
}

