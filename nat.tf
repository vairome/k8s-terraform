resource "aws_eip" "nat" {
  vpc = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
