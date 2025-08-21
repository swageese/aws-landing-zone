output "eip_public_ip" { value = aws_eip.web_ip.public_ip }
output "instance_id" { value = aws_instance.web.id }
