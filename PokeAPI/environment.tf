

provider "aws" {
  region = var.region  # Use the region variable
}

# Create a VPC (Virtual Private Cloud)
resource "aws_vpc" "poke_vpc" {
  cidr_block = var.vpc_cidr_block  # Use the VPC CIDR block variable
}

# Create a subnet in the VPC
resource "aws_subnet" "poke_subnet" {
  vpc_id            = aws_vpc.poke_vpc.id
  cidr_block        = var.subnet_cidr_block  # Use the subnet CIDR block variable
  availability_zone = var.availability_zone  # Use the availability zone variable
}

# Create a Security Group
resource "aws_security_group" "poke_sg" {
  vpc_id = aws_vpc.poke_vpc.id

  # Allow SSH access to EC2 instances (port 22)
  ingress {
    from_port   = var.ssh_port  # Use the SSH port variable
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Flask API access (port 5000)
  ingress {
    from_port   = var.flask_api_port  # Use the Flask API port variable
    to_port     = var.flask_api_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP web app access (port 80)
  ingress {
    from_port   = var.http_port  # Use the HTTP port variable
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # Allow access to game app (port 8080)
  ingress {
    from_port   = var.game_app_port  # Port 8080 for the game app
    to_port     = var.game_app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access from anywhere
  }


  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allocate an Elastic IP for the backend EC2 instance
resource "aws_eip" "poke_backend_eip" {
  instance = aws_instance.backend_instance.id  # Attach the EIP to your EC2 instance
}

# If you want to ensure the Elastic IP is associated with the game instance as well
resource "aws_eip" "poke_game_eip" {
  instance = aws_instance.game_instance.id  # Attach the EIP to your game EC2 instance
}
