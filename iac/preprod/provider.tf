terraform {
  required_version = ">= 1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "c3ops-terraform-statefiles"
    key            = "c3_core_infra_preprod/terraform.tfstate"
    region         = "ap-south-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
    profile        = "c3"
  }
}

provider "aws" {
  region  = var.aws_region
  # profile = "c3"

  default_tags {
    tags = {
      Environment = var.environment
      Application = var.project_name
      CostCenter  = "c3ops"
      Billing     = "shared"
      Owner       = "platform-team"
    }
  }
}


