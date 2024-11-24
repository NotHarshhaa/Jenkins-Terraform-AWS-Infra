data "aws_ami" "latest_amazon_linux_img" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Private Network Interface for App Instance
resource "aws_network_interface" "private_network_interface" {
  subnet_id       = var.public_subnet_id  # Ensure this variable is declared in variables.tf
  security_groups = [var.app_sg_id]       # Ensure this variable is declared in variables.tf
  private_ips     = [var.app_private_ip]  # Ensure this variable is declared in variables.tf
}

# App Instance
resource "aws_instance" "app" {
  ami                       = data.aws_ami.latest_amazon_linux_img.id
  instance_type             = var.app_instance_type  # Ensure this variable is declared in variables.tf
  key_name                  = var.key_name           # Ensure this variable is declared in variables.tf
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = var.app_volume_size  # Ensure this variable is declared in variables.tf
  }

  network_interface {
    network_interface_id = aws_network_interface.private_network_interface.id
    device_index         = 0
  }

  tags = {
    Name = "${var.vendor}-${var.environment}-app"
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }
}

# Private Network Interface for DB Instance
resource "aws_network_interface" "db_network_interface" {
  subnet_id       = var.private_subnet_id  # Ensure this variable is declared in variables.tf
  security_groups = [var.db_sg_id]         # Ensure this variable is declared in variables.tf
  private_ips     = [var.db_private_ip]    # Ensure this variable is declared in variables.tf
}

# DB Instance
resource "aws_instance" "db" {
  ami           = data.aws_ami.latest_amazon_linux_img.id
  instance_type = var.db_instance_type  # Ensure this variable is declared in variables.tf
  key_name      = var.key_name         # Ensure this variable is declared in variables.tf

  root_block_device {
    volume_type = "gp2"
    volume_size = var.db_volume_size  # Ensure this variable is declared in variables.tf
  }

  network_interface {
    network_interface_id = aws_network_interface.db_network_interface.id
    device_index         = 0
  }

  tags = {
    Name = "${var.vendor}-${var.environment}-db"
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }
}
