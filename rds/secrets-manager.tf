# Native Terraform resource tool to generate a 16 character password 
resource "random_password" "rds_passwd" {
  length  = 16
  special = true
}

# Creates a secrets manager file to store secrets
resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "rds/credentials" # File path
}

# Creates a json file to upload to secrets manager specified file location
resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.rds_passwd.result
  })
}