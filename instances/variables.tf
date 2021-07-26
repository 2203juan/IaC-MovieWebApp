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
  default = "myEc2KeyPair"
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