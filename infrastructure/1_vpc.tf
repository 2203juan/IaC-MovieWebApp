
# Set provider settings by using region variable (declared in variables.tf)
provider "aws" {
  region = var.region
}

# Remote backend configuration
terraform {
  backend "s3" {}
}

# Resource Creation - aws

# VPC settings
resource "aws_vpc" "production_vpc_juan" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "Production-VPC",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}