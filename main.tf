module "ec2" {
    source = "./ec2"
    # public_key_path = "~/.ssh/id_rsa.pub"  
}

module "rds" {
    source = "./rds"
}