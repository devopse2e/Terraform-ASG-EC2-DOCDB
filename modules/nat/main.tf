resource "aws_eip" "nat_eip" {
    count = var.create_nat ? 1 : 0

    #vpc = true

    tags = {
      Name = "${var.name_prefix}-nat-eip"
    }
}

resource "aws_nat_gateway" "nat_gw" {
    count = var.create_nat ? 1 : 0

    allocation_id = aws_eip.nat_eip[0].id
    subnet_id = var.public_subnet_id

    tags = {
      Name = "${var.name_prefix}-nat-gw"
    }
}