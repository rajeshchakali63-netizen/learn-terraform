terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.70.0"
    }
  }
   backend "s3" {
    bucket       = "roboshop-tf-remote-s3"
    key          = "remote-state-demo.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}



provider "aws" {
  region = "us-east-1"
}