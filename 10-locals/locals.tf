locals {
    instance_type = "t3.micro"
    Name = "${var.project}-${var.environment}"
    common_tags = {
        project = var.project
        Environment = var.environment
        Terraform = true
    }
    ec2_tags = merge(
        local.common_tags,
        {
            Name = "${local.Name}-locals-demo"
        }
    )
}