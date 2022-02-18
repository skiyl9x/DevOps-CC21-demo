
resource "aws_secretsmanager_secret" "db_master" {
  name_prefix = "db_master-"
  description = "Master password for MariaDB server"
}

resource "aws_secretsmanager_secret_version" "db_master_ver" {
  secret_id     = aws_secretsmanager_secret.db_master.id
  secret_string = random_password.list[0].result
}
