# IP range for the entire VPC.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}


# subnet is linked to VPC, and uses a /24 CIDR block, is then placed in a the london region, and assigns public IPs to instances by default.
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true
}

# This enables internet access from the VPC (for public subnets). It attaches to the VPC I created.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Controls how traffic is routed within the VPC. This one will be associated with the public subnet.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

# This just basically means any destination
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# This links the public subnet to the public route table, which points to the internet gateway. Without this, the EC2 in the subnet would not have internet access, even if everything else was set up.
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}