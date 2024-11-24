# Create and Assign Route Tables

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-rt-public"
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-rt-private"
  }

  lifecycle {
    ignore_changes = [
      route,
    ]
  }
}

# Associate Public Route Table with Subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public.id
}

# Associate Private Route Table with Subnet
resource "aws_route_table_association" "private_association" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private.id
}
