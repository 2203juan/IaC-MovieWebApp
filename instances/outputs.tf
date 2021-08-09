output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.dbmovie.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.dbmovie.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.dbmovie.username
  sensitive   = true
}

output "rds_replica_connection_params" {
  description = "RDS replica instance connection parameters"
  value       = "-h ${aws_db_instance.dbmovie_replica.address} -p ${aws_db_instance.dbmovie_replica.port} -U ${aws_db_instance.dbmovie_replica.username} mysql"
}

data "aws_instances" "public" {
  filter {
    name = "instance.group-id"
    values = [aws_security_group.ec2_public_security_group.id]
  }
   instance_state_names = ["running"]
}
/*
data "aws_instances" "private" {
  filter {
    name = "instance.group-id"
    values = [aws_security_group.ec2_private_security_group.id]
  }
   instance_state_names = ["running"]
}

output "ec2_public_ips" {
  description = "EC2 public ip's adress"
  value = data.aws_instances.public.ids
}

output "ec2_private_ips" {
  description = "EC2 pruvate ip's adress"
  value = data.aws_instances.private.ids
}*/