# CREATE AND ASSIGN ROUTE TABLES

resource "aws_route_table" "route-table-public" {
  vpc_id = data.aws_vpc.existing_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-rt-public"
  }
}

resource "aws_route_table" "route-table-private" {
  vpc_id = data.aws_vpc.existing_vpc.id
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

resource "aws_route_table_association" "route-table-public-association-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.route-table-public.id
}

resource "aws_route_table_association" "route-table-private-association-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.route-table-private.id
}
