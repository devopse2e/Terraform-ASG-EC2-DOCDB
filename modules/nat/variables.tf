variable "public_subnet_id" {
    description = "public subnet ID to deploy nat gw in"
    type = string
}

variable "name_prefix" {
    description = "Name prefix for resources"
    type = string
}

variable "create_nat" {
    description = "create nat flag"
    type = bool
    default = false
  
}