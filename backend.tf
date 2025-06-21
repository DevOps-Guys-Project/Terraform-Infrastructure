terraform {
  backend "s3" {
    bucket       = "s3-state-bucket-devopsguys"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true #S3 native locking
  }
}