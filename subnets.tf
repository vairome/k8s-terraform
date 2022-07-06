
resource "aws_subnet" "rds-subnet-1" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "rds-subnet-us-east-1a"
  }
}

resource "aws_subnet" "rds-subnet-2" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "rds-subnet-us-east-1b"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds-subnet-group"
  description = "Postgres subnet group"
  subnet_ids  = ["${aws_subnet.rds-subnet-1.id}", "${aws_subnet.rds-subnet-2.id}"]

}

resource "aws_security_group" "rds_sg" {
  name = "postgres-rds-sg"

  description = "RDS security group for Postgres RDS instances"
  vpc_id      = aws_vpc.demo.id

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