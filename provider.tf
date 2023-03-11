terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }

  backend "s3" {
    bucket = "master-terraform-backend-s3"
    key = "s3_backend.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = var.region
}
