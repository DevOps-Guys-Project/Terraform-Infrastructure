# Data block retrieves secrets manager file from specified location
data "aws_secretsmanager_secret" "rds_credentials" {
  name = "rds/credentials"
}

# Data block retrieves specific file version (latest) by default
data "aws_secretsmanager_secret_version" "db" {
  secret_id = data.aws_secretsmanager_secret.rds_credentials.id
}

# Local block allows for variable creation to use configuration wide
locals {
  db_username = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string).username
  db_password = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string).password
}