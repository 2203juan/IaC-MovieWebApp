resource "aws_security_group" "bastion_SG" {
  name = "SSH-SG"
  vpc_id = data.terraform_remote_state.network_configuration.outputs.vpc_id

  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = [var.ssh_allow_host]
    # security_groups = [aws_security_group.ec2_public_security_group.id]
  }

  egress {
    from_port = var.database_default_port
    protocol = "TCP"
    to_port = var.database_default_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "BASTION SG",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }

}

# leventar instancia con ip publica manual, asociar SSH-SG
# asociar ip privada de la instancia a rds -> inbound rule
# conectarse por ssh a la instancia y desde ahi conectarse a la base de datos

/*resource "aws_network_interface" "foo" {
  subnet_id   = data.terraform_remote_state.network_configuration.outputs.public_subnet_1_id
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "bastion" {
  ami = "ami-0e28822503eeedddc"
  availability_zone = "ca-central-1a"
  vpc_security_group_ids = [aws_security_group.bastion_SG.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  instance_type = var.ec2_instance_type
  key_name = var.key_pair_name
  associate_public_ip_address = true

  tags = {
    Name = "Bastion EC2"
  }
}*/