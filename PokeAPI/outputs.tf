output "backend_instance_ip" {
  value = aws_instance.backend_instance.public_ip
  description = "Public IP of the backend EC2 instance"
}

output "game_instance_ip" {
  value = aws_instance.game_instance.public_ip
  description = "Public IP of the game EC2 instance"
}
