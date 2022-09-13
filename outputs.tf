output "webserver_address" {
  value = aws_instance.webserver.public_ip
}

output "deployserver_address" {
  value = aws_instance.deployserver.public_ip
}