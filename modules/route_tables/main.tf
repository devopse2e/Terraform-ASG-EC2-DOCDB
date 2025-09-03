#public route

resource "aws_route_table" "public" {
    vpc_id = var.vpc_id
    
    tags = {
      Name = "${var.name_prefix}-public-rt"
    }
}

resource "aws_route" "public_internet_access" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
}

resource "aws_route_table_association" "public_assoc" {
    count = length(var.public_subnet_id)
    subnet_id = var.public_subnet_id[count.index]
    route_table_id = aws_route_table.public.id
}

#private route
resource "aws_route_table" "private" {
    count  = length(var.private_subnet_id)
    vpc_id = var.vpc_id
    
    tags = {
      Name = "${var.name_prefix}-private-rt-${element(var.azs,count.index)}"
    }
}


resource "aws_route" "private_nat_gw" {
    count  = length(var.private_subnet_id)
    route_table_id = aws_route_table.private[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_id
}

resource "aws_route_table_association" "private_assoc" {
    count = length(var.private_subnet_id)
    subnet_id = var.private_subnet_id[count.index]
    route_table_id = aws_route_table.private[count.index].id
}