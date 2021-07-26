# Creating Public Security Group
resource "aws_security_group" "ec2_public_security_group" {
  name = "EC2-PUBLIC_SG"
  description = "Internet Reaching access for EC2 Instances"
  vpc_id = data.terraform_remote_state.network_configuration.outputs.vpc_id

  ingress {
    from_port = 3030
    protocol = "TCP"
    to_port = 3030
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = ["200.29.100.15/32"]
  }

  egress {
    from_port = 0
    protocol = "-1" # open all out rule
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating Private Security Group
resource "aws_security_group" "ec2_private_security_group" {
  name = "EC2-Private-SG"
  description = "Only allow public SG resources to access these instances"
  vpc_id = data.terraform_remote_state.network_configuration.outputs.vpc_id

  # allow access from public SG
  ingress {
    from_port = 3000 # port exposed by backend
    protocol = "TCP"
    to_port = 3000
    security_groups = [aws_security_group.ec2_public_security_group.id]
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
}


# Database security group
resource "aws_security_group" "database_security_group" {
  name = "DB-SG"
  description = "Database Security Group"
  vpc_id = data.terraform_remote_state.network_configuration.outputs.vpc_id

  ingress {
    from_port = 3306
    protocol = "TCP"
    to_port = 3306
    security_groups = [aws_security_group.ec2_private_security_group.id]
  }

  egress {
    from_port = 3306
    protocol = "TCP"
    to_port = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3306
    protocol = "TCP"
    to_port = 3306
    security_groups = [aws_security_group.bastion_SG.id] # abrir enlace para mysql desde el bastion
  }

}