# Create a EC2 Instance for PokeAPI Game 
resource "aws_instance" "game_instance" {
  ami           = "ami-0a91cd140a1fc148a"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"  # Free tier instance type
  subnet_id     = aws_subnet.poke_subnet.id
  security_groups = [aws_security_group.poke_sg.name]

  tags = {
    Name = "PokeAPI-Game"
  }

# User data script to set up the EC2 instance
  user_data = <<-EOF
              #!/bin/bash
              # Update system and install Docker
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user  # Allow ec2-user to use Docker
              sudo docker build -t pokemon-game .
              docker run -d --name pokemon_game -p 8080:8080 <your_pokemon_game_image>
              EOF
}
