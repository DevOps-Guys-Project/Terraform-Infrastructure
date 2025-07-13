# Migrates statefile (terraform.tfstate) to an S3 bucket
terraform {
  backend "s3" {
    bucket       = "s3-state-bucket-devopsguys"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true #S3 native locking
  }
}