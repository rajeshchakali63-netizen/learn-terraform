resource "aws_instance" "web" {
  ami           = "ami-0055977a6e828a4f4" 
  instance_type = "t3.micro"   
  # Attach the security group by referencing its ID
  vpc_security_group_ids = [aws_security_group.web.id]
         

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
