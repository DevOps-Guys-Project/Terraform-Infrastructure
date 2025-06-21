# Creates a module from local ec2 directory, adding config files from directory 
module "ec2" {
    source = "./ec2"
    # public_key_path = "~/.ssh/id_rsa.pub"  # Requires value but no value to input so remains commented out currently.
}

# Creates a module from local rds directory, adding config files from directory 
module "rds" {
    source = "./rds"
}