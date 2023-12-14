# Create a VPC

resource "aws_vpc" "alprestamo-vpc" {
    cidr_block = var.vpc-cidr-block
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "${var.record_name}-${var.codigo-pais}-${var.environment}"
    }
  
}

# Create a Public Subnet

resource "aws_subnet" "dev-pub-main-subnet" {
    vpc_id = aws_vpc.alprestamo-vpc.id
    cidr_block = var.pub-main-subnet-cidr
    availability_zone = var.az-pub-main
    tags = {
      Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-public-main"
    }
      
}

resource "aws_subnet" "dev-pub-alt-subnet" {
    vpc_id = aws_vpc.alprestamo-vpc.id
    cidr_block = var.pub-alt-subnet-cidr
    availability_zone = var.az-pub-alt
    tags = {
      Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-public-alt"
    }
      
}


#Create an Internet gateway for public subnet

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.alprestamo-vpc.id
  tags = {
    Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-ig"
    environment = var.environment
  }
}

# Create an Elastic IP for NatGateway

resource "aws_eip" "nat_eip" {
  depends_on = [ aws_internet_gateway.ig ]
  tags = {
    Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-natgw-eip"
  }

}

# Create a Nat Gateway

resource "aws_nat_gateway" "natg" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.dev-pub-main-subnet.id
  tags = {
    Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-natgw"
  }
}

# Create a Public Route Table

resource "aws_route_table" "route_table_pub" {
  vpc_id = aws_vpc.alprestamo-vpc.id

  route {
    cidr_block = var.vpc-cidr-block
    gateway_id = var.gateway-id-a
  }
  route {
    cidr_block = var.cidr-block-cero
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-rt-public"
  }

  depends_on = [ aws_internet_gateway.ig ]
}

#Associate Public RT to public subnets

resource "aws_route_table_association" "pub-main" {
  subnet_id = aws_subnet.dev-pub-main-subnet.id
  route_table_id = aws_route_table.route_table_pub.id
}

resource "aws_route_table_association" "pub-alt" {
  subnet_id = aws_subnet.dev-pub-alt-subnet.id
  route_table_id = aws_route_table.route_table_pub.id
}

# Create a Private Route Table

resource "aws_route_table" "route_table_priv" {
  vpc_id = aws_vpc.alprestamo-vpc.id

  route {
    cidr_block = var.vpc-cidr-block
    gateway_id = var.gateway-id-a
  }
  route {
    cidr_block = var.cidr-block-cero
    gateway_id = aws_nat_gateway.natg.id
  }

  tags = {
    Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-rt-private"
  }
}

#Associate Private RT to private subnets

resource "aws_route_table_association" "priv-main" {
  subnet_id = aws_subnet.dev-priv-main-subnet.id
  route_table_id = aws_route_table.route_table_priv.id
}

resource "aws_route_table_association" "priv-alt" {
  subnet_id = aws_subnet.dev-priv-alt-subnet.id
  route_table_id = aws_route_table.route_table_priv.id
}

# Create a Private Subnet

resource "aws_subnet" "dev-priv-main-subnet" {
    vpc_id = aws_vpc.alprestamo-vpc.id
    cidr_block = var.priv-main-subnet-cidr
    availability_zone = var.az-priv-main
    tags = {
      Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-priv-main"
    }
      
}

resource "aws_subnet" "dev-priv-alt-subnet" {
    vpc_id = aws_vpc.alprestamo-vpc.id
    cidr_block = var.priv-alt-subnet-cidr
    availability_zone = var.az-priv-alt
    tags = {
      Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-priv-alt"
    }
      
}

# Create a Security Group

resource "aws_security_group" "alprestamo-sg" {
  name        = "allow_basic_traffic"
  description = "Allow basic inbound traffic"
  vpc_id      = aws_vpc.alprestamo-vpc.id

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.vpc-cidr-block]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.vpc-cidr-block]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.vpc-cidr-block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "necessary opened ports"
  }
}
