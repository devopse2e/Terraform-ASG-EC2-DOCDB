variable "ami_id" {
    description = "ami id for the ec2"
    type = string
}
variable "instance_type" {
    description = "instance type for the ec2"
    type = string
}
variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the ASG to launch instances in"
  type        = list(string)
}

variable "key_name" {
    description = "ssh key"
    type = string
  
}
variable "backend_sg_id" {
    description = "sg id for the ec2"
    type = string
  
}
variable "name_prefix" {
  description = "Prefix for naming SGs"
  type        = string
}

variable "mongo_uri" {
    description = "uri for the mongodb"
    type = string
    sensitive = true
  
}
variable "port" {
    description = "backend port to access frontend"
    type = number
    default = 3001
  
}
variable "jwt_secret" {
    description = "jwt token secret"
    type = string
    sensitive = true
    default = "RFBfr3t/W+MU25ri7529BJCfep8dJ+re6DfKey/2NMM="
  
}

variable "target_group_arn" {
    description = "tg arn of the backend alb"
    type = string
}

variable "desired_capacity" {
  description = "The desired number of instances for the ASG to maintain"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "The minimum number of instances the ASG can scale down to"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of instances the ASG can scale up to"
  type        = number
  default     = 4
}