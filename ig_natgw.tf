# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = data.aws_vpc.existing_vpc.id
  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-ig"
  }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.gw]
}

# Create NAT Gateway
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = data.aws_subnet.public_subnet_1.id
  depends_on    = [aws_internet_gateway.gw]
  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-nat-gw"
  }
}
