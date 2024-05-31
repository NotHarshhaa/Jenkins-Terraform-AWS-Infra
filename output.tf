output "ec2-app-public-ip" {
    value = aws_instance.app.public_ip
}