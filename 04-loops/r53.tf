resource "aws_route53_record" "roboshop" {
  count = 10
  zone_id = var.zone_id
  name    = "${var.instances[count.index]}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.roboshop[count.index].private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "frontend" {
  count = contains(var.instances, "frontend") ? 1 : 0
  zone_id = var.zone_id
  name    = "${var.domain_name}" # rajdaws92sdaws92s.store
  type    = "A"
  ttl     = 1
  records = [aws_instance.roboshop[index(var.instances, "frontend")].public_ip]
  allow_overwrite = true
}