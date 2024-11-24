# Create VPC
resource "aws_vpc" "development_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-vpc"
  }
}

# Query the created VPC (optional)
data "aws_vpc" "existing_vpc" {
  id = aws_vpc.development_vpc.id
}
