#VPC Module

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "${var.name_prefix}-vpc"
    }
  
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.name_prefix}-public-subnet-${var.azs[count.index]}"
    }
  
}

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.name_prefix}-private-subnet-${var.azs[count.index]}"
    }
  
}