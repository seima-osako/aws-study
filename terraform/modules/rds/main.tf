############################
# DB Subnet Group
############################
resource "aws_db_subnet_group" "main" {
  name        = "${var.prefix}-rds-subnet-group"
  description = "RDS private subnets (3AZ)"
  subnet_ids  = var.db_subnet_ids
  tags = {
    Name = "${var.prefix}-rds-subnet-group"
  }
}

############################
# RDS Instance
############################
resource "aws_db_instance" "mysql" {
  identifier                = "${var.prefix}-mysql"
  engine                    = "mysql"
  engine_version            = "8.0.39"
  instance_class            = "db.t4g.micro"
  allocated_storage         = 20
  storage_type              = "gp2"
  db_subnet_group_name      = aws_db_subnet_group.main.name
  vpc_security_group_ids    = [var.rds_sg_id]
  username                  = var.db_username
  password                  = var.db_password
  backup_retention_period   = 1
  multi_az                  = false
  publicly_accessible       = false
  deletion_protection       = false
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.prefix}-mysql-final"
  tags = {
    Name = "${var.prefix}-mysql"
  }
}
