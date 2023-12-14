########################## EC2-ALB ##########################

ami = "ami-0cbd40f694b804622"
checo-ami = "ami-0cbd40f694b804622"
instance_type = "t2.micro"
key_name = "alprestamo"
certificate_arn = "arn:aws:acm:us-west-1:145628923514:certificate/b6953fda-67b2-4668-a619-cbf2cd9c9db3"
# private_key_path = "./modules/ec2_alb/alprestamo.pem"




########################## R53 ##########################

domain_name = "webhostingcloudtest.click"
record_name = "alprestamo"

########################## VPC ##########################

vpc-cidr-block = "10.20.0.0/16"
pub-main-subnet-cidr = "10.20.40.0/24"
pub-alt-subnet-cidr = "10.20.60.0/24"
priv-main-subnet-cidr = "10.20.0.0/24"
priv-alt-subnet-cidr = "10.20.20.0/24"
az-pub-main = "us-west-1b"
az-pub-alt = "us-west-1c"
az-priv-main = "us-west-1b"
az-priv-alt = "us-west-1c"
codigo-pais = "test"
vpc_security_group_ids = ["sg-0a14bfc6581cfc984"]
vpc_id = "vpc-0a1541057fbc156f3"
environment = "dev"
gateway-id-a = "local"
cidr-block-cero = "0.0.0.0/0"

########################## CDN Variables ##########################

origin-id = "alprestamos3Origin"
acm-certificate-arn = "arn:aws:acm:us-east-1:145628923514:certificate/b71fb968-dcde-404f-860b-e5f49b10cce9"