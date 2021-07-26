# Elastic Ip creation for nat gateway
resource "aws_eip" "elastic-ip-for-nat-gw" {
  vpc = true
  associate_with_private_ip = "10.0.0.5"

  tags = {
    Name = "Production-EIP"
  }
}

# Creating a Nat Gateway

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elastic-ip-for-nat-gw.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "Production-NAT-GW"
  }

  depends_on = [aws_eip.elastic-ip-for-nat-gw]
}

# Associate it to the private route table
resource "aws_route" "nat-gw-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}