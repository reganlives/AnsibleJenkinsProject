provider "aws" {
  region     = "us-east-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "BasicVPC" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "${"var.name"}.tf.vpc"
    }
}

resource "aws_internet_gateway" "BasicIG" {
    vpc_id = aws_vpc.BasicVPC.id
    tags = {
        name = "${var.name}.tf.igw"
    }
}

resource "aws_subnet" "BasicPublicSubnet" {
    vpc_id = aws_vpc.BasicVPC.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-2a"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.name}.tf.subnet"
    }
}

resource "aws_subnet" "BasicPrivateSubnet" {
    vpc_id = aws_vpc.BasicVPC.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-2a"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.name}.tf.private.subnet"
    }
}

resource "aws_security_group" "sgPublic" {
  name        = "Basic_ec2_sg"
  description = "Allow http and SSH traffic"
  vpc_id      = aws_vpc.BasicVPC.id
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP Inbound"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP Inbound"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "name" = "${var.name}.tf.basic.sg"
  }
}

resource "aws_route_table" "BasicRouteTable" {
    vpc_id = aws_vpc.BasicVPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.BasicIG.id
    }
    tags = {
        Name = "${var.name}.tf.routeTable"
    }
}

resource "aws_route_table_association" "publicSubAssoc" {
    subnet_id = aws_subnet.BasicPublicSubnet.id
    route_table_id = aws_route_table.BasicRouteTable.id
}

resource "aws_instance" "webserver" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.ssh_key
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.BasicPublicSubnet.id
  vpc_security_group_ids      = [aws_security_group.sgPublic.id]
  #user_data = "${file("install_apache.sh")}"

  tags = {
    "name" = "Basic Webserver"
  }
}

resource "null_resource" "CopyScript" {

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.webserver.id
    private_key = var.ssh_key
    #user     = "${var.admin_username}"
    #password = "${var.admin_password}"
  }

  # provisioner "file" {
  #   source      = "./docker-start.sh"
  #   destination = "./home/docker-start.sh"
  # }

}

