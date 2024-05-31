# CREATE SG FOR Database
resource "aws_security_group" "db-sg-grp" {
  name          = "${var.vendor}-${var.environment}-db-sg"
  description   = "Sg for DB"
  vpc_id        = data.aws_vpc.existing_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${aws_network_interface.private_network_interface.id}/32"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_network_interface.private_network_interface.id}/32"]
  }
}

# CREATE SG FOR App
resource "aws_security_group" "app-sg-grp" {
  name          = "${var.vendor}-${var.environment}-app-sg"
  description   = "Sg for app"
  vpc_id        = data.aws_vpc.existing_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0" ]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0" ]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0" ]
  }
}

