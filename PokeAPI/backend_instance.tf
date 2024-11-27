# Create a EC2 Instance for Backend System
resource "aws_instance" "backend_instance" {
  ami           = "ami-0a91cd140a1fc148a"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"  # Use a t2.micro instance for the free tier
  subnet_id     = aws_subnet.poke_subnet.id
  security_groups = [aws_security_group.poke_sg.name]

  tags = {
    Name = "PokeAPI-Backend"
  }
# User data script to set up the EC2 instance
user_data = <<-EOF
              #!/bin/bash
              
              # Update the system and install Docker
              sudo yum update -y  # Update packages
              sudo yum install -y docker  # Install Docker
              sudo service docker start  # Start Docker service
              sudo usermod -a -G docker ec2-user  # Add user to Docker group

              # Start MongoDB container
              sudo docker run -d \  # Run MongoDB container in background
                --name mongo \  # Container name
                -p 27017:27017 \  # Expose MongoDB port
                -v /data/db:/data/db \  # Persistent storage
                -e MONGO_INITDB_ROOT_USERNAME=admin \  # Set MongoDB root username
                -e MONGO_INITDB_ROOT_PASSWORD=secret_password \  # Set password
                mongo:latest  # Use latest MongoDB image

###ליצור תמונת פלאסק
              # Start Flask API container
              sudo docker run -d \  # Run Flask container in background
                --name pokeapi-flask \  # Container name
                -p 5000:5000 \  # Expose Flask API port
                --link mongo:mongo \  # Link MongoDB container
                -v /path/to/your/flask/app:/app \  # Mount Flask app
                flask-app-image:latest  # Use Flask app image
              EOF
}