output "instance_public_ip" {
    value = aws_instance.yview_instance.public_ip
}

output "instance_id" {
    value = aws_instance.yview_instance.id
}

output "site_url" {
    value = "http://${var.domain_url}/"
}