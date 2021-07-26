# Public Route Table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.production_vpc_juan.id

  tags = {
    Name = "Public-Route-Table",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

# Private Route Table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.production_vpc_juan.id

  tags = {
    Name = "Private-Route-Table",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

# Public Route Table - Associations
resource "aws_route_table_association" "public_subnet-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_subnet-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_subnet_2.id
}

resource "aws_route_table_association" "public_subnet-3-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_subnet_3.id
}

# Private Route Table - Associations
resource "aws_route_table_association" "private_subnet-1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "private_subnet-2-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private_subnet_2.id
}

resource "aws_route_table_association" "private_subnet-3-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id = aws_subnet.private_subnet_3.id
}