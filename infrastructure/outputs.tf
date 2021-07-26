/*
This file contains useful variables from first layer
that may be needed in layer two for creating computing resources
(Remote State Reading)
*/

output "vpc_id" {
  value = aws_vpc.production_vpc_juan.id
}

output "vpc_cidr_block" {
  value = aws_vpc.production_vpc_juan.cidr_block
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "public_subnet_3_id" {
  value = aws_subnet.public_subnet_3.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "private_subnet_3_id" {
  value = aws_subnet.private_subnet_3.id
}