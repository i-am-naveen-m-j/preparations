provider "aws" {
  region = var.region
}

resource "aws_key_pair" "example" {
  key_name   = "terraform-demo-naveen"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
  tags       = { Name = var.vpc_name }
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.subnet_name}-pub" }
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
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id
  tags                   = { Name = var.machine_name }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  # Jenkins installation provisioners
  provisioner "remote-exec" {
    inline = [
      /*
      "echo 'Hello Started installation of java_11'",
      "sudo apt update",
      "sudo apt install -y openjdk-11-jre",
      "sudo apt-get install -y openjdk-11-jre-headless",
      "echo 'Java installation completed. Waiting for a moment to update PATH.'",
      "sleep 10",
      "java -version",
*/
  
    "echo 'Hello Started installation of java_11'",
    "/usr/bin/sudo /usr/bin/apt update",
    "/usr/bin/sudo /usr/bin/apt install -y openjdk-11-jre",
    "/usr/bin/sudo /usr/bin/apt-get install -y openjdk-11-jre-headless",
    "echo 'Java installation completed. Waiting for a moment to update PATH.'",
    "sleep 10",
    "/usr/bin/java -version",


    ]
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Started installation of Jenkins'",
      "curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y jenkins",
      "sudo systemctl start jenkins",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Displaying Jenkins initialAdminPassword'",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
      "echo 'Jenkins installation completed. Default user: Admin, and the password is printed above.'",
    ]
  }
}
