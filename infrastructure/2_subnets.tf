# ----------Public Subnets--------------------------

# Public Subnet - zone-1 settings
resource "aws_subnet" "public_subnet_1" {
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_vpc.production_vpc_juan.id
  availability_zone = var.zone_1

  tags = {
    Name = "Public-Subnet-1",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

# Public Subnet - zone-2 settings
resource "aws_subnet" "public_subnet_2" {
  cidr_block        = var.public_subnet_2_cidr
  vpc_id            = aws_vpc.production_vpc_juan.id
  availability_zone = var.zone_2

  tags = {
    Name = "Public-Subnet-2",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

# Public Subnet - zone-3 settings
resource "aws_subnet" "public_subnet_3" {
  cidr_block        = var.public_subnet_3_cidr
  vpc_id            = aws_vpc.production_vpc_juan.id
  availability_zone = var.zone_3

  tags = {
    Name = "Public-Subnet-3",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}
# --------------------------------------------------

# ----------Private Subnets--------------------------

# Private Subnet - zone-1 settings
resource "aws_subnet" "private_subnet_1" {
  cidr_block        = var.private_subnet_1_cidr
  vpc_id            = aws_vpc.production_vpc_juan.id
  availability_zone = var.zone_1

  tags = {
    Name  = "Private-Subnet-1",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

# Private Subnet - zone-2 settings
resource "aws_subnet" "private_subnet_2" {
  cidr_block        = var.private_subnet_2_cidr
  vpc_id            = aws_vpc.production_vpc_juan.id
  availability_zone = var.zone_2

  tags = {
    Name  = "Private-Subnet-2",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

# Private Subnet - zone-3 settings
resource "aws_subnet" "private_subnet_3" {
  cidr_block        = var.private_subnet_3_cidr
  vpc_id            = aws_vpc.production_vpc_juan.id
  availability_zone = var.zone_3

  tags = {
    Name  = "Private-Subnet-3",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

# --------------------------------------------------