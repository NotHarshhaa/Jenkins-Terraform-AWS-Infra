data "aws_ami" "latest_amazon_linux_img" {
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_network_interface" "private_network_interface" {
  subnet_id          = aws_subnet.public-subnet-1.id
  security_groups    = [aws_security_group.app-sg-grp.id]
  private_ips        = ["10.0.10.10"]
}

resource "aws_instance" "app" {
    ami                       = data.aws_ami.latest_amazon_linux_img.id
    instance_type             = "t2.micro"
    root_block_device {
        volume_type         = "gp2"
        volume_size         = 30
    }
    associate_public_ip_address = true
    network_interface {
        network_interface_id = aws_network_interface.private_network_interface.id
        device_index = 0
    }
    key_name = "tests"
    tags = {
        Name = "${var.vendor}-${var.environment}-app"
    }
    lifecycle {
        ignore_changes = [
            ami,
        ]
    }
}

resource "aws_network_interface" "network_interface" {
  subnet_id          = aws_subnet.private-subnet-1.id
  security_groups    = [aws_security_group.db-sg-grp.id]
  private_ips        = ["10.0.110.10"]
}

resource "aws_instance" "db" {
    ami                       = data.aws_ami.latest_amazon_linux_img.id
    instance_type             = "t2.micro"
    root_block_device {
        volume_type         = "gp2"
        volume_size         = 50
    }
    network_interface {
        network_interface_id = aws_network_interface.network_interface.id
        device_index = 0
    }
    key_name = "tests"
    tags = {
        Name = "${var.vendor}-${var.environment}-db"
    }
    lifecycle {
        ignore_changes = [
            ami,
        ]
    }
}