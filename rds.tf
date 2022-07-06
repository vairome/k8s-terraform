
resource "aws_db_instance" "pern-postgres" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "14.1"
  instance_class         = "db.t3.micro"
  identifier             = "pern-db-instance"
  db_name                = "postgres"
  username               = "postgres"
  password               = "password"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.id
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot    = true
}