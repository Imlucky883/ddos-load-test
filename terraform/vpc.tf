resource "aws_vpc" "main" {
    cidr_block = var.main_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
    Name = "main"
    }
}

data "aws_availability_zones" "main" {
    state = "available"
}

resource "aws_subnet" "public-subnet" {
  count = length(var.public_cidr_block)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_cidr_block[count.index]
  availability_zone = data.aws_availability_zones.main.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "main-gw"
  }
}

resource "aws_route_table" "public-route" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public_route"
    }
}

resource "aws_route_table_association" "public-route-association" {
  count          = length(var.public_cidr_block)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_security_group" "presentation_tier" {
    name = "presnetation_tier_sg"
    description = "Presentation_tier security group"
    vpc_id = aws_vpc.main.id

    ingress {
    from_port = 80
    to_port = 80
    description = "HTTP from anywhere"
    security_groups = [aws_security_group.alb_frontend.id]
    protocol = "tcp"
    }
    ingress {
    from_port = 22
    to_port = 22
    description = "HTTP from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "alb_frontend" {
    name = "web-tier-sg"
    description = "alb frontend security group"
    vpc_id = aws_vpc.main.id

    ingress {
    from_port = 80
    to_port = 80
    description = "HTTP from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}