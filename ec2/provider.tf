terraform {
  required_version = "~> 1.12.1" # Terraform version

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.99.1" # AWS provider version
    }
  }
}

# AWS region to spin up resources from this config repository
provider "aws" {
  region = "eu-west-2"
}