provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "ubuntu" {
  ami                    = "ami-0775b32552c39d15c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, ygpark" > index.html
              nohup busybox httpd -f -p 9090 &
              EOF

  tags = {
    Name = "ygpark-web"
  }
}

resource "aws_security_group" "instance" {
  name = var.security_group_name

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-ygpark-instance"
}

output "public_ip" {
  value       = aws_instance.ubuntu.public_ip
  description = "The public IP of the Instance"
}
