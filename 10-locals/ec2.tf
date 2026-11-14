resource "aws_instance" "locals_demo" {
  ami           = var.ami_id 
  instance_type = local.instance_type
  # Attach the security group by referencing its ID
  vpc_security_group_ids = [aws_security_group.locals_demo.id]
         

  tags = local.common_tags
}

# 2. Create the Security Group
resource "aws_security_group" "locals_demo" {
  name        = "roboshop-locals_demo"
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

  tags = local.common_tags
}
