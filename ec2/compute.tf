resource "aws_instance" "web" {
  ami                         = "ami-0b3878627e2736f0b"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public_http_traffic.id]
  key_name                    = aws_key_pair.ec2_key.key_name

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  tags = merge(local.common_tags, {
    Name = "resources-ec2"
  })
}

# used this page: cloud-images.ubuntu.com/locator/ec2/ to get a list of AMI IDs based on for example region 

resource "aws_security_group" "public_http_traffic" {
  description = "Security group allowing traffic on ports 443 and port 80 (port 80 for demo purposes)"
  name        = "public-http-traffic"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "resources-sg"
  })
}



resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}
