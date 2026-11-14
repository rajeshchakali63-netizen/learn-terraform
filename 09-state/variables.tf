

variable  "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type of EC2"
}

variable "ec2_tags" {
    type = map
    default = {
        Name = "roboshop-mongodb"
        Environment = "dev"
        Terraform = "true"
        Project = "roboshop"
        Component = "mongodb"
    }
}
variable "cidr" {
    type = list
    default = ["0.0.0.0/0"]
}

variable "from_port" {
    type = number
    default = 0
}