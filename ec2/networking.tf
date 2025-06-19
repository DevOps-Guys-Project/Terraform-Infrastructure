# IP range for the entire VPC.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"


  tags = {
    Name = "resources"
    ManagedBy = "Terraform"
    Project = "DevOpsGuys"
  }
}



# subnet is linked to VPC, and uses a /24 CIDR block, is then placed in a the london region, and assigns public IPs to instances by default.
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true 


  tags = {
    Name = "resources"
    ManagedBy = "Terraform"
    Project = "DevOpsGuys"
  }
}
