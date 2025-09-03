#Jumpbox SG
resource "aws_security_group" "jump_box_sg" {
    name = "${var.name_prefix}-jumpbox-sg"
    description = "allowed ssh cidr for access"
    vpc_id = var.vpc_id

    ingress {
        description = "ssh ports"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.allowed_ssh_cidr]
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-jumpbox-sg"
  } 
}

# ALB (INTERNET Facing)

resource "aws_security_group" "internet_alb_sg" {
    name = "${var.name_prefix}-internet-alb-sg"
    description = "internet facing alb sg"
    vpc_id = var.vpc_id

    ingress {
        description = "HTTP traffic from public internet"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    egress {
    description = "Allowed outbound traffic to jump box"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "${var.name_prefix}-internet-alb-sg"
  } 
}


#Frontend EC2 SG

resource "aws_security_group" "frontend_sg" {
    name = "${var.name_prefix}-frontend-sg"
    description = "frontend sg"
    vpc_id = var.vpc_id

    ingress {
        description = "HTTP traffic from alb internet"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.internet_alb_sg.id]
        
    }
    ingress {
        description = "allow port 3000 from internet alb"
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        security_groups = [aws_security_group.internet_alb_sg.id]
        
    }

    ingress {
    description     = "SSH from Jump Box"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jump_box_sg.id]
  }
    egress {
    description = "Allowed outbound traffic to ALB(internal)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-frontend-sg"
  } 
}

# ALB (INTERNAL Facing)

resource "aws_security_group" "internal_alb_sg" {
    name = "${var.name_prefix}-internal-alb-sg"
    description = "internal facing alb sg"
    vpc_id = var.vpc_id

    ingress {
        description = "allow traffic from frontend ec2 sg"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.frontend_sg.id]
        
    }
    egress {
    description = "Allowed outbound traffic to backend instance"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "${var.name_prefix}-internal-alb-sg"
  } 
}

#Backend EC2 SG

resource "aws_security_group" "backend_sg" {
    name = "${var.name_prefix}-backend-sg"
    description = "backend ec2 sg"
    vpc_id = var.vpc_id

    
    ingress {
        description     = "SSH from Jump Box"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        security_groups = [aws_security_group.jump_box_sg.id]
        }

    ingress {
    description     = "allow frontend access from of app from frontend ec2 sg"
    from_port       = 3001
    to_port         = 3001
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_alb_sg.id]
  }

    egress {
    description = "Allowed outbound traffic to mongodb sg"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-backend-sg"
  } 
}

resource "aws_security_group" "mongodoc_sg" {
    name = "${var.name_prefix}-mongodoc-sg"
    description = "mongo document db sg"
    vpc_id = var.vpc_id

    ingress {
        description = "inbound traffic from backend sg"
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        security_groups = [aws_security_group.backend_sg.id]
        
    }
    ingress {
    description     = "enable session connectivity from jumpbox"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.jump_box_sg.id]
  }
    egress {
    
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-mongodoc-sg"
  } 
}