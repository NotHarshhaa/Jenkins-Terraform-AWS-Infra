# Create Subnets

# Define Availability Zones for multi-AZ support
locals {
  availability_zones = ["${var.region}a", "${var.region}b"]  # Support for multiple AZs if needed
}

# Public Subnet
resource "aws_subnet" "public" {
  for_each = toset(local.availability_zones)

  vpc_id            = var.vpc_id
  cidr_block        = element(var.public_cidr_blocks, index(local.availability_zones, each.value))
  availability_zone = each.value

  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-public-${each.value}"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  for_each = toset(local.availability_zones)

  vpc_id            = var.vpc_id
  cidr_block        = element(var.private_cidr_blocks, index(local.availability_zones, each.value))
  availability_zone = each.value

  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-private-${each.value}"
  }
}
