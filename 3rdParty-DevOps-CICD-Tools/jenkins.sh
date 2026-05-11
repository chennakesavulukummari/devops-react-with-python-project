# 1. Define the AWS Provider
provider "aws" {
  region = "ap-south-2" # Change to your preferred region
}

# 2. Get the latest Ubuntu 24.04 AMI
# data "aws_ami" "ubuntu" {
#   most_recent = true
#   owners      = ["318095823459"] # Canonical
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-noble-24.04-amd64-server-*"]
#   }
# }

# 3. Create a Security Group for Jenkins
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-security-group"
  description = "Allow SSH and Jenkins port"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For security, replace with your IP
  }

  ingress {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. Launch EC2 Instance with Installation Script
resource "aws_instance" "jenkins_server" {
  ami                    = "ami-024ebedf48d280810"
  instance_type          = "t3.medium" # Recommended: 2 vCPUs, 4GB RAM
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = "azure-agent" # Ensure this exists in your AWS account

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y fontconfig openjdk-21-jre

              # Java Env
              # Detect JAVA_HOME automatically
              export JAVA_HOME=$(dirname "$(dirname "$(readlink -f "$(which java)")")")

              # Add Java to PATH
              export PATH=$JAVA_HOME/bin:$PATH

              # Verify
              echo $JAVA_HOME
              java -version
              javac -version
              
              # Add Jenkins repository and key
              sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
              echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

              sudo apt update -y
              sudo apt install -y jenkins
              sudo systemctl enable --now jenkins
              EOF

  tags = {
    Name = "Jenkins-Server-2026"
  }
}

output "jenkins_url" {
  value = "http://$${aws_instance.jenkins_server.public_ip}:8080"
}