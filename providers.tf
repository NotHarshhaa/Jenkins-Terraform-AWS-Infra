# Define Required Providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.70.0" # Allow compatibility with future updates
    }
  }
}

# AWS Provider Configuration
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
