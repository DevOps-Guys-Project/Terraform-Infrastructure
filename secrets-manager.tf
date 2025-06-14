resource "random_password" "rds_passwd" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "rds/credentials"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.rds_passwd.result
  })
}