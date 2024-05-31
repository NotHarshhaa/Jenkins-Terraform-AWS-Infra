# CREATE VPC


resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name = "${lower(var.vendor)}-${lower(var.environment)}-vpc"
    }
}

data "aws_vpc" "existing_vpc" {
    #"query existing resources"
    id = aws_vpc.development-vpc.id
}

