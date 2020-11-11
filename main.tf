# Create security groups for Proving Ground proving groupd 
# 

provider "aws" {
  region =  var.region 
}

# Adding Security Group for Proving Ground Instance :
resource "aws_security_group" "barn-sg" {
  name        = "Proving Ground"
  description = "Proving Ground Web Server Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ var.ClientIp ]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ var.ClientIp ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
# EC2 resource

resource "aws_instance" "barn-instance" {
  ami                    = var.ami_id
  instance_type          = var.instancetype
  key_name               = var.keyname
  subnet_id              = var.subnetid
  vpc_security_group_ids = [aws_security_group.barn-sg.id]

  user_data = <<-DATA
              #!/bin/bash
			  sudo yum install xfsprogs -y
              sudo mkfs -t xfs /dev/xvdf
			  sudo mkdir /data
			  sudo mount /dev/xvdf /data
			  sudo chown -R ec2-user:ec2-user /data
			  sudo su 
			  echo "/dev/xvdf  /data  xfs  defaults,nofail  0  2" >> /etc/fstab
			  exit
              DATA

  tags = {
    Name = var.AppName
    Env  = var.Env
  }

  lifecycle {
    create_before_destroy = true
  }
}
