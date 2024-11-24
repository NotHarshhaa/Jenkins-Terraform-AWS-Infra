# Security Group for Database
resource "aws_security_group" "db_sg" {
  name        = "${lower(var.vendor)}-${lower(var.environment)}-db-sg"
  description = "Security Group for Database"
  vpc_id      = var.vpc_id

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound MySQL traffic from App instance
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.app_private_ip}/32"]
  }

  # Allow SSH access (if required, from a specific range or trusted IPs)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
  }

  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-db-sg"
  }
}

# Security Group for Application
resource "aws_security_group" "app_sg" {
  name        = "${lower(var.vendor)}-${lower(var.environment)}-app-sg"
  description = "Security Group for Application"
  vpc_id      = var.vpc_id

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access (if required, from a specific range or trusted IPs)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
  }

  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-app-sg"
  }
}
