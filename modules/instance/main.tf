variable "ami_id" {
}

variable "instance_type" {
}

variable "tags" {
}

variable "ingress_rules" {
}

variable "sg_name" {  
}

variable "egress_rules" {
  
}

variable "bucket_name" {
  
}

variable "acl" {
  
}

variable "s3tag" {
  
}

provider "aws" {
  access_key = <"credencial en texto plano o variable de entorno"> 
  secret_key = <"credencial en texto plano o variable de entorno"> 
  region = "us-east-1"
}

resource "aws_security_group" "ssh_conection" {
  name = var.sg_name
  dynamic "ingress" {
    for_each = var.ingress_rules
    content { 
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = var.egress_rules
    content { 
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
  subnet_id     = "subnet-0c7f87c455a7e9071"
  vpc_security_group_ids = [aws_security_group.ssh_conection.id]
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
      host        = self.public_ip
    }
    inline = [
      "sudo docker run --name ami-platzi -d -p 8080:80 nginx"
    ]
  }

}

resource "aws_s3_bucket" "backend" {
    bucket = var.bucket_name
    acl= var.acl
    tags = var.s3tag
    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = "${aws_kms_key.mykey.arn}"
          sse_algorithm = "aws:kms"
        }
      }
    }
}

resource "aws_kms_key" "mykey" {
  description = "key"
  deletion_window_in_days = 10
  
}

terraform {
  backend "s3" {
    bucket = "backend"
    key = "dev"
    region = "us-east1"
    encrypt = true
    kms_key_id = <"ARN">
  }
}