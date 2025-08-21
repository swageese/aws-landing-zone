# Security Group
resource "aws_security_group" "web_sg" {
  name        = "${var.project}-web-sg"
  description = "Allow HTTP/HTTPS (and SSH if needed)"
  vpc_id      = var.vpc_id
  tags = { Project = var.project }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Optional SSH (recommend lock to your IP)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Latest Amazon Linux 2023 in region
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["137112412989"] # Amazon
  filter { 
    name = "name"
   values = ["al2023-ami-*-x86_64"] 
   }
}

# Simple user data to serve a landing page
locals {
  user_data = <<-EOT
    #!/bin/bash
    dnf install -y httpd
    systemctl enable httpd
    echo "<h1>${var.project} landing zone up</h1>" > /var/www/html/index.html
    systemctl start httpd
  EOT
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = true
  user_data                   = local.user_data

  tags = { Name = "${var.project}-web", Project = var.project }
}

# Elastic IP for stable DNS
resource "aws_eip" "web_ip" {
  domain   = "vpc"
  instance = aws_instance.web.id
  tags = { Project = var.project }
}

