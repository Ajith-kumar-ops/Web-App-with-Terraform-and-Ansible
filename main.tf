provider "aws" {
  region = "us-east-1"
}

# SSH Key Pair using your Windows key
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-ajith"  # Changed name
  public_key = file("C:/Users/AjithK/.ssh/deployer-key.pem.pub")
}

# Security Group allowing SSH and HTTP access
resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance with user_data to install Python3
resource "aws_instance" "web" {
  ami                    = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI (us-east-1)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install python3 -y
              EOF

  tags = {
    Name = "ansible-web"
  }
}
