# Creating iam role for ec2
resource "aws_iam_role" "ec2_iam_role" {
  name               = "EC2-IAM-Role"
  assume_role_policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement":
  [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ["ec2.amazonaws.com", "application-autoscaling.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Name = "IAM ROLE FOR EC2 INSTANCES",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

# Creating policies to the iam role
resource "aws_iam_role_policy" "ec2_iam_role_policy" {
  name = "EC2-IAM-Policy"
  role = aws_iam_role.ec2_iam_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "elasticloadbalancing:*",
        "cloudwatch:*",
        "logs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Creating instance profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2-IAM.Instance-Profile_rampup"
  role = aws_iam_role.ec2_iam_role.name

  tags = {
    Name = "EC2-INSTANCE-PROFILE",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}



data "aws_ami" "launch_configuration_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

  tags = {
    Name = "AWS-AMI",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

data "template_file" "user_data_back" {
  template = templatefile("../scripts/back.tpl",
  {
    host_endpoint = aws_db_instance.dbmovie.address,
    user_name = var.db_user_name,
    password = var.db_password
  })
}

data "template_file" "user_data_front" {
  template = templatefile("../scripts/front.tpl",{ back_host = aws_elb.backend_load_balancer.dns_name})
}

resource "aws_launch_configuration" "ec2_private_launch_configuration" {
  image_id = data.aws_ami.launch_configuration_ami.id
  instance_type = var.ec2_instance_type
  key_name = var.key_pair_name
  associate_public_ip_address = var.ec2_private_ec2_public_ip
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups = [aws_security_group.ec2_private_security_group.id]

  user_data =  data.template_file.user_data_back.rendered

  depends_on = [aws_db_instance.dbmovie]
}


resource "aws_launch_configuration" "ec2_public_launch_configuration" {
  image_id = data.aws_ami.launch_configuration_ami.id
  instance_type = var.ec2_instance_type
  key_name = var.key_pair_name
  associate_public_ip_address = var.ec2_public_ec2_public_ip
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups = [aws_security_group.ec2_public_security_group.id]


  user_data = data.template_file.user_data_front.rendered

}