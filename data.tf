data "aws_secretsmanager_secret" "rds_credentials" {
  name = "rds/credentials"
}

data "aws_secretsmanager_secret_version" "db" {
  secret_id = data.aws_secretsmanager_secret.rds_credentials.id
}

locals {
  db_username = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string).username
  db_password = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string).password
}