# Creating Public Security Group
resource "aws_security_group" "ec2_public_security_group" {
  name = "EC2-PUBLIC_SG"
  description = "Internet Reaching access for EC2 Instances"
  vpc_id = data.terraform_remote_state.network_configuration.outputs.vpc_id

  ingress {
    from_port = var.frontend_default_port
    protocol = "TCP"
    to_port = var.frontend_default_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH
  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = [var.ssh_allow_host_1]
  }

  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = [var.ssh_allow_host_2]
  }

  egress {
    from_port = 0
    protocol = "-1" # open all out rule
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-PUBLIC_SG",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

# Creating Private Security Group
resource "aws_security_group" "ec2_private_security_group" {
  name = "EC2-Private-SG"
  description = "Only allow public SG resources to access these instances"
  vpc_id = data.terraform_remote_state.network_configuration.outputs.vpc_id

  # allow access from public SG
  ingress {
    from_port = var.backend_default_port # port exposed by backend
    protocol = "TCP"
    to_port = var.backend_default_port
    security_groups = [aws_security_group.ec2_public_security_group.id]
  }

  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    security_groups = [aws_security_group.bastion_SG.id]
  }

  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = [var.ssh_allow_host_2] #allow ssh for jenkins
  }
  # allow health checking for instances using this SG
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow health checking for instances using this SG"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "EC2-Private-SG",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }


}

# Creating Elastic Load Balancer Security Group
resource "aws_security_group" "elb_security_group" {
  name = "ELB-SG"
  description = "ELB Security Group"
  vpc_id = data.terraform_remote_state.network_configuration.outputs.vpc_id

  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow web traffic to load balancer"
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ELB-SG",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }

}


# Database security group
resource "aws_security_group" "database_security_group" {
  name = "DB-SG"
  description = "Database Security Group"
  vpc_id = data.terraform_remote_state.network_configuration.outputs.vpc_id

  ingress {
    from_port = var.database_default_port
    protocol = "TCP"
    to_port = var.database_default_port
    security_groups = [aws_security_group.ec2_private_security_group.id,aws_security_group.bastion_SG.id]
  }

  egress {
    from_port = var.database_default_port
    protocol = "TCP"
    to_port = var.database_default_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = var.database_default_port
    protocol = "TCP"
    to_port = var.database_default_port
    security_groups = [aws_security_group.bastion_SG.id] # open access for mysql from bastion instance
  }

  tags = {
    Name = "DB-SG",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }

}