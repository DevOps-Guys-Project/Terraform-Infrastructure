resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "devops-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  filename        = "${path.module}/../secrets/devops-key.pem"
  content         = tls_private_key.ec2_key.private_key_pem
  file_permission = "0600"
}
