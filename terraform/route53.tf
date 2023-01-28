# DNS stuff
resource "aws_route53_record" "yview_dns_record" {
  zone_id = var.zone_id
  name    = "${var.domain_url}."
  type    = "A"
  ttl     = 300
  records = [aws_instance.yview_instance.public_ip]
}