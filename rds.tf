
resource "aws_db_instance" "pern-postgres" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "14.1"
  instance_class         = "db.t3.micro"
  identifier             = "pern-db-instance-${terraform.workspace}"
  db_name                = "postgres"
  username               = "postgres"
  password               = "password"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.id
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot    = true
}

resource "aws_security_group" "rds_sg" {
  name = "postgres-rds-sg-${terraform.workspace}"

  description = "RDS security group for Postgres RDS instances"
  vpc_id      = aws_vpc.main.id

  # Inbound traffic
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}