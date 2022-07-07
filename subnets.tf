resource "aws_subnet" "eks-subnet" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id

  tags = tomap({
    "Name"                                      = "terraform-eks-node-${terraform.workspace}",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}
resource "aws_subnet" "rds-subnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "rds-subnet-us-east-1a-${terraform.workspace}"
  }
}

resource "aws_subnet" "rds-subnet-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "rds-subnet-us-east-1b-${terraform.workspace}"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds-subnet-group-${terraform.workspace}"
  description = "Postgres subnet group"
  subnet_ids  = ["${aws_subnet.rds-subnet-1.id}", "${aws_subnet.rds-subnet-2.id}"]

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