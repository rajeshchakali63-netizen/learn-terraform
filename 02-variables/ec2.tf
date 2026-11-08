resource "aws_instance" "web" {
  ami           = var.ami_id 
  instance_type = var.instance_type 
  # Attach the security group by referencing its ID
  vpc_security_group_ids = [aws_security_group.web.id]
         

  tags = var.ec2_tags
}

# 2. Create the Security Group
resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow inbound SSH and HTTP traffic"

  # Inbound Rule: Allow SSH
  ingress {
    from_port   = var.from_port
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
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
