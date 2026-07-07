resource "aws_db_subnet_group" "main" {
  name = "${var.environment}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.environment}-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "${var.environment}-postgres-db"

  engine                 = "postgres"
  engine_version         = "16"

  instance_class         = var.db_instance_class
  allocated_storage      = 20

  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_security_group_id]

  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "${var.environment}-postgres-db"
  }
}