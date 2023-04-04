
// aws_instance :

ami_id="ami-019f1519fcf323805"
instance_type="t2.micro"
tags={
 Name="amorcito-mio",
 Enviroment="Prod"  
}

// aws_securiry_groups :

sg_name = "ssh-access-test"
ingress_rules = [ 
  {
    from_port = "22" 
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port = "8080" 
    to_port = "8080"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

egress_rules = [ 
  {
    from_port = "0" 
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
]

// bucket s3

s3tag = {
Enviroment = "Dev" }
acl = "private"
bucket_name = "backend"