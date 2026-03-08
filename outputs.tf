output "Manager_Public_IP" {
  value = aws_instance.noc_manager.public_ip
}

output "App_Server_Public_IP" {
  value = aws_instance.app_server.public_ip
}
