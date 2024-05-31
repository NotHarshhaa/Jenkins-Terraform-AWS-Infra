# CREATE SUBNET

locals {
    availability_zones = "${var.region}a"
}

resource "aws_subnet" "public-subnet-1" {
    vpc_id     = data.aws_vpc.existing_vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = local.availability_zones
    tags = {
        Name = "${lower(var.vendor)}-${lower(var.environment)}-public-${local.availability_zones}"
    }
}


resource "aws_subnet" "private-subnet-1" {
    vpc_id     = data.aws_vpc.existing_vpc.id
    cidr_block = var.cidr_blocks[2].cidr_block
    availability_zone = local.availability_zones
    tags = {
        Name = "${lower(var.vendor)}-${lower(var.environment)}-private-${local.availability_zones}"
    }
}
