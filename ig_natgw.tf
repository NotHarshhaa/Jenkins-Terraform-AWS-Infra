# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-ig"
  }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  network_border_group = "us-west-2"  # Replace with the appropriate AWS region
  depends_on           = [aws_internet_gateway.gw]
  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-nat-eip"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id
  depends_on    = [aws_internet_gateway.gw]
  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-nat-gw"
  }
}
