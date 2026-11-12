resource "aws_instance" "roboshop" {
  for_each = var.instances
  instance_type = each.value.instance_type
  ami = var.ami_id
  vpc_security_group_ids = [
        aws_security_group.common.id,
        aws_security_group.roboshop[each.key].id
    ]

  tags = {
    Name = "${var.project}-${var.environment}-${each.key}"
  }
}

resource "aws_security_group" "common" {
  name        = "${var.project}-${var.environment}-common"
  description = "A common SG for all the instances of roboshop"
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-${var.environment}-common"
  }
}

resource "aws_security_group" "roboshop" {
  #count = 10
  for_each = var.instances
  name        = "${var.environment}-${each.key}"
  description = "A component SG for the instance of roboshop"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-${var.environment}-${each.key}"
  }
}