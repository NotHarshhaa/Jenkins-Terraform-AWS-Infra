vendor       = "example"
environment  = "dev"
region       = "us-west-2"

vpc_cidr_block        = "10.0.0.0/16"
public_cidr_blocks    = ["10.0.10.0/24", "10.0.20.0/24"]  # Example for two AZs
private_cidr_blocks   = ["10.0.110.0/24", "10.0.120.0/24"] # Example for two AZs

vpc_id = "vpc-xxxxxxxx"  # Provide the VPC ID here, or use a reference if the VPC is being created

app_private_ip = "10.0.10.10"  # Specify the private IP for the app instance

public_subnet_id = "subnet-xxxxxxxx"  # Specify the public subnet ID here
private_subnet_id = "subnet-xxxxxxxx"  # Specify the private subnet ID here

app_sg_id = "sg-xxxxxxxxxxxxxxxxx"  # Replace with the actual security group ID for your app instance
db_sg_id  = "sg-yyyyyyyyyyyyyyyyy"  # Replace with the actual security group ID for your database instance

app_instance_type = "t2.micro"  # Or any instance type you want
db_instance_type  = "t2.micro"  # Or any instance type you want

key_name = "my-ssh-key"  # Replace with your actual SSH key name

app_volume_size = 30  # Or any size you want
db_volume_size  = 50  # Or any size you want

db_private_ip = "10.0.110.10"  # Replace with the actual private IP address you want for the DB instance
