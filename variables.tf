# Vendor and Environment Variables
variable "vendor" {
  type = string
}

variable "environment" {
  type = string
}

# AWS Region
variable "region" {
  type    = string
  default = "us-west-2"
}

# AWS Access and Secret Keys
variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

# Public Subnet CIDR Blocks (list of CIDR blocks for each availability zone)
variable "public_cidr_blocks" {
  description = "CIDR blocks for the public subnets in each availability zone"
  type        = list(string)
}

# Private Subnet CIDR Blocks (list of CIDR blocks for each availability zone)
variable "private_cidr_blocks" {
  description = "CIDR blocks for the private subnets in each availability zone"
  type        = list(string)
}

# Security Group CIDR blocks (optional)
variable "allowed_ssh_cidr_blocks" {
  description = "CIDR blocks allowed to access SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Replace with trusted IPs as needed
}

# Declare VPC ID variable
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "app_private_ip" {
  description = "Private IP address of the application instance"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
}

variable "app_sg_id" {
  description = "Security group ID for the app instance"
  type        = string
}

variable "db_sg_id" {
  description = "Security group ID for the database instance"
  type        = string
}

variable "app_instance_type" {
  description = "The instance type for the app server"
  type        = string
  default     = "t2.micro"  # You can specify a default instance type here, or leave it empty to require input
}

variable "db_instance_type" {
  description = "The instance type for the database server"
  type        = string
  default     = "t2.micro"  # You can specify a default instance type here, or leave it empty to require input
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the instances"
  type        = string
}

variable "app_volume_size" {
  description = "The size of the root volume for the app instance (in GB)"
  type        = number
  default     = 30  # You can specify a default value, or leave it empty to require input
}

variable "db_volume_size" {
  description = "The size of the root volume for the database instance (in GB)"
  type        = number
  default     = 50  # You can specify a default value, or leave it empty to require input
}

variable "db_private_ip" {
  description = "The private IP address for the database instance"
  type        = string
}
