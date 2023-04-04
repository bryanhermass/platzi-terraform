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
 
module "my-app" {
  source = <"ruta remota de git">
  sg_name = var.sg_name
  ingress_rules = var.ingress_rules
  egress_rules = var.egress_rules
  tags = var.tags
  instance_type = var.instance_type
  ami_id = var.ami_id
  bucket_name = var.bucket_name
  acl = var.acl
  s3tag = var.s3tag
}  