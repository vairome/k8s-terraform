resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-rds"
  }
}

resource "aws_route_table" "private-eks" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id

  }
  tags = {
    Name = "private-eks"
  }
}

resource "aws_route_table_association" "private-eks-subnets" {
  count = 2

  subnet_id      = aws_subnet.eks-subnet.*.id[count.index]
  route_table_id = aws_route_table.private-eks.id
}

 resource "aws_route_table_association" "private-us-east-1a" {
   subnet_id      = aws_subnet.rds-subnet-1.id
   route_table_id = aws_route_table.private.id
 }

 resource "aws_route_table_association" "private-us-east-1b" {
   subnet_id      = aws_subnet.rds-subnet-2.id
   route_table_id = aws_route_table.private.id
 }

 resource "aws_route_table_association" "public-us-east" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public.id
}
