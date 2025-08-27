provider "aws" {
  region = var.aws_region
}

# 0. S3+DynamoDB para control de versionamiento del estado de Terraform
terraform {
  backend "s3" {
    bucket         = "paw-s3-terraform-state"
    key            = "prod/terraformIAM.tfstate"
    region         = "us-east-1"
    dynamodb_table = "paw-dynamodb-terraform-locks"
    encrypt        = true
  }
}
