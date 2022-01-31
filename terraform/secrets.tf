#Generate secrets for services
#
#
#

variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

provider "aws" {
  region = var.region
}

resource "random_password" "list" {
  count            = 2
  length           = 16
  special          = true
  override_special = "!@$&"
}

resource "aws_secretsmanager_secret" "db_master" {
  name_prefix = "db_master-"
  description = "Master password for MariaDB server"
}

resource "aws_secretsmanager_secret_version" "db_master_ver" {
  secret_id     = aws_secretsmanager_secret.db_master.id
  secret_string = random_password.list[0].result
}

resource "aws_secretsmanager_secret" "db_user" {
  name_prefix = "db_user-"
  description = "User password for MariaDB server"
}

resource "aws_secretsmanager_secret_version" "db_user_ver" {
  secret_id     = aws_secretsmanager_secret.db_user.id
  secret_string = random_password.list[1].result
}
