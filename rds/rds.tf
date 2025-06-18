resource "aws_db_instance" "rds_mysql" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7.44"
  instance_class          = "db.t3.micro"
  username                = local.db_username
  password                = local.db_password
  skip_final_snapshot     = true
  publicly_accessible     = false
  backup_retention_period = 7
  availability_zone       = "eu-west-2a"
  multi_az                = false
  tags = {
    Name = "FreeTierMySQL"
  }
}
