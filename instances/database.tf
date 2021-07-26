resource "aws_db_subnet_group" "db_subnet_group" {

  subnet_ids = [
    data.terraform_remote_state.network_configuration.outputs.private_subnet_1_id,
    data.terraform_remote_state.network_configuration.outputs.private_subnet_2_id,
    data.terraform_remote_state.network_configuration.outputs.private_subnet_3_id]

  tags = {
    Name = "DB SUBNET GROUP",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}


resource "aws_db_instance" "dbmovie" {
  identifier = "dbmovie"
  instance_class = "db.t3.micro"
  allocated_storage = 5
  engine = "mysql"
  engine_version = "8.0"
  backup_retention_period = 1
  username = var.db_user_name
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name = "MAIN DATABASE",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}

resource "aws_db_instance" "dbmovie_replica" {
  identifier = "dbmoviereplica"
  replicate_source_db = aws_db_instance.dbmovie.identifier
  instance_class = "db.t3.micro"
  apply_immediately = true
  publicly_accessible = false
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.database_security_group.id]

  tags = {
    Name = "Database Replica",
    Purpose = "RampUp",
    Student = "Juan Jose Hoyos Urcue"
  }
}