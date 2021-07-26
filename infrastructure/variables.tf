/*
This is a variables file used for declaring
useful variables called from 1_vpc.tf file
*/

# Region settings
variable "region" {
  default     = "ca-central-1"
  description = "AWS Region"
}

# VPC_CIDR_BLOCK
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR BLOCK"
}

# -----------Public Subnets------------

variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 CIDR"
}

variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 CIDR"
}

variable "public_subnet_3_cidr" {
  description = "Public Subnet 3 CIDR"
}

# --------------------------------------


#-------------Private Subnets-----------

variable "private_subnet_1_cidr" {
  description = "Private Subnet 1 CIDR"
}

variable "private_subnet_2_cidr" {
  description = "Private Subnet 2 CIDR"
}

variable "private_subnet_3_cidr" {
  description = "Private Subnet 3 CIDR"
}
# --------------------------------------

