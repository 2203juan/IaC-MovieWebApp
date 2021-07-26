# Creating Internet Gateway

resource "aws_internet_gateway" "production-igw" {
  vpc_id = aws_vpc.production_vpc_juan.id

  tags = {
    Name = "Production-IGW"
  }
}

# Associate it to the public route table
resource "aws_route" "public-internet-gw-route" {
  route_table_id = aws_route_table.public-route-table.id
  gateway_id = aws_internet_gateway.production-igw.id
  destination_cidr_block = "0.0.0.0/0"
}