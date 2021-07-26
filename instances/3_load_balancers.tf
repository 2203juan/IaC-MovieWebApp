resource "aws_elb" "webapp_load_balancer" {
  name = "Production-WebApp-LoadBalancer"
  internal = false
  security_groups = [aws_security_group.elb_security_group.id]
  subnets = [
    data.terraform_remote_state.network_configuration.outputs.public_subnet_1_id,
    data.terraform_remote_state.network_configuration.outputs.public_subnet_2_id,
    data.terraform_remote_state.network_configuration.outputs.public_subnet_3_id ]


  listener {
    instance_port = 3030
    instance_protocol = "HTTP"
    lb_port = 80
    lb_protocol = "HTTP"
  }

  health_check {
    healthy_threshold = 5
    interval = 30
    target = "HTTP:3030/"
    timeout = 10
    unhealthy_threshold = 5
  }
}

resource "aws_elb" "backend_load_balancer" {
  name = "Production-Backend-LoadBalancer"
  internal = true
  security_groups = [aws_security_group.elb_security_group.id]
  subnets = [
    data.terraform_remote_state.network_configuration.outputs.private_subnet_1_id,
    data.terraform_remote_state.network_configuration.outputs.private_subnet_2_id,
    data.terraform_remote_state.network_configuration.outputs.private_subnet_3_id ]

  listener {
    instance_port = 3000
    instance_protocol = "HTTP"
    lb_port = 3000
    lb_protocol = "HTTP"
  }

  health_check {
    healthy_threshold = 5
    interval = 30
    target = "HTTP:3000/"
    timeout = 10
    unhealthy_threshold = 5
  }
}