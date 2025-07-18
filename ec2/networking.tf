locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "DevOpsGuys"
  }
}

# IP range for the entire VPC.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = "resources"
  })
}


# subnet is linked to VPC, and uses a /24 CIDR block, is then placed in a the london region, and assigns public IPs to instances by default.
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "resources-public"
  })
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "resources-main"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(local.common_tags, {
    Name = "resources-main"
  })
}


resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

