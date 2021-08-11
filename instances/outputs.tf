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