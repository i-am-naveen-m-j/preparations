# Define the AWS provider configuration.
provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region.
}

variable "cidr" {
  default = "10.0.0.0/16"
}

resource "aws_key_pair" "example" {

  ## Use this cmd to generate both pub and private keys on gitbah terminal ##   
  ###   ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa      ###
  ## Your identification has been saved in /c/Users/cnbna/.ssh/id_rsa
  ##   Your public key has been saved in /c/Users/cnbna/.ssh/id_rsa.pub
       
  key_name   = "terraform-demo-naveen"  # Replace with your desired key name
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key file

}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "HTTP from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

resource "aws_instance" "server" {
  ami                    = "ami-03f4878755434977f"
  instance_type          = "t2.micro"
  key_name      = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/id_rsa")  # Replace with the path to your private key
    host        = self.public_ip
  }




/*
####    Nginx run   ###
  
  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y nginx",  # Example package installation
      "sudo systemctl start nginx",  # Start Nginx

    ]
    
  }

   provisioner "file" {
    source      = "custom_index.html"
    destination = "/home/ubuntu/custom_index.html"
  }


  provisioner "remote-exec" {
    inline = [

      "sudo mv /home/ubuntu/custom_index.html /var/www/html/index.nginx-debian.html",  # Replace the default index.html
      "sudo systemctl restart nginx",  # Restart Nginx to apply changes
    ]
    
  }


*/
########### jenkins ##########

  provisioner "remote-exec" {
  inline = [
    "echo 'Hello Started installation of java_11'",
    "sudo apt update",
    "sudo apt install -y openjdk-11-jre",
    "sudo apt-get install -y openjdk-11-jre-headless",  # additional installation step
    "echo 'Java installation completed. Waiting for a moment to update PATH.'",
    "sleep 10",  # wait for 10 seconds to ensure PATH is updated
    "java -version",
  ]
}



  provisioner "remote-exec" {
    inline = [
      "echo 'Started installtion of jenkins'",

      "curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y jenkins",
      "sudo systemctl start jenkins",  # Start Jenkins


    ]

  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Started installtion of jenkins'",

      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",

      "echo 'Started installtion Sucessfully default User: Admin  and password is printed above line '",


    ]
  }











}