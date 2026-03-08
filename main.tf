provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "noc_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "NOC-Lab-VPC"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.noc_vpc.id
  tags = {
    Name = "NOC-Gateway"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.noc_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "NOC-Public-Subnet"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.noc_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "NOC-Route-Table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "noc_sg" {
  name        = "noc_security_group"
  description = "Allow SSH and Netdata ports"
  vpc_id      = aws_vpc.noc_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 19999
    to_port     = 19999
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
    Name = "NOC-Security-Group"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "noc-key-pair"
  public_key = file("my-aws-key.pub")
}

resource "aws_instance" "noc_manager" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.auth.key_name
  vpc_security_group_ids = [aws_security_group.noc_sg.id]

  tags = {
    Name = "NOC-Manager"
  }
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.auth.key_name
  vpc_security_group_ids = [aws_security_group.noc_sg.id]

  tags = {
    Name = "Client-App-Server"
  }
}
