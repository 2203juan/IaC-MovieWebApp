variable "region" {
  default     = "ca-central-1"
  description = "AWS Region"
}

variable "remote_state_bucket" {
  description = "Bucket name for layer 1 remote state"
}

variable "remote_state_key" {
  description = "Key name for layer 1 remote state"
}

variable "ec2_instance_type" {
  description = "EC2-Instance type to launch"
}

variable "key_pair_name" {
  default = "juan.hoyosu"
  description = "Keypair to use to connect to EC2-Instances"
}

variable "max_instance_size" {
  description = "Maximum number of instances to launch"
}

variable "min_instance_size" {
  description = "Minimum number of instances to launch"
}

variable "db_user_name" {
  default = "movie_database"
  description = "Database Username"
}

variable "db_password" {
  description = "Database Password"
}

variable "backend_default_port" {
  description = "BackEnd Default Port"
  default = 3000
}

variable "frontend_default_port" {
  description = "FrontEnd Default Port"
  default = 3030
}

variable "ssh_allow_host_1" {
  description = "SSH ALLOW HOST IP 1 -> use: ip_adress/32"
  default = "200.29.100.15/32"
}

variable "ssh_allow_host_2" {
  description = "SSH ALLOW HOST IP 2 -> use: ip_adress/32"
  default = "3.96.189.233/32"
}

variable "database_default_port" {
  description = "Database Default Port"
  default = "3306"
}

variable "front_load_balancer_port" {
  description = "Frontend load balancer port"
  default = 80
}

variable "back_load_balancer_port" {
  description = "Backend load balancer port"
  default = 3000
}

variable "ec2_private_ec2_public_ip" {
  description = "Public Ec2 Ip Adress for private instances? (true or false)"
  default = false
}

variable "ec2_public_ec2_public_ip" {
  description = "Public Ec2 Ip Adress for public instances? (true or false)"
  default = true
}

variable "propagate_autoscaling_tags" {
  description = "Propagate autoscaling tags? (true or false)"
  default = false
}