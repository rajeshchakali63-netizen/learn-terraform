resource "aws_instance" "web" {
  ami           = "ami-0055977a6e828a4f4" 
  instance_type = "t3.micro"   
  # Attach the security group by referencing its ID
  vpc_security_group_ids = [aws_security_group.web.id]
         
    provisioner "local-exec" {
      command = "echo ${self.private_ip} > inventory.ini"
    }

    provisioner "local-exec" {
      command = "echo ${self.public_ip} > inventory.ini"
    }

    provisioner "local-exec" {
      command = "echo instance created"
    }

    provisioner "local-exec" {
      when = "destroy"
      command = "echo 'Instance is going to be destroyed' " #echo > inventory.ini
    }

    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = self.public_ip
    }

    provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  tags = {
    Name        = "roboshop-web"
    Environment = "Dev"
  }
}

# 2. Create the Security Group
resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow inbound SSH and HTTP traffic"

  # Inbound Rule: Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For production, restrict this to your IP
  }

  # Outbound Rule: Allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-web-sg"
  }
}
