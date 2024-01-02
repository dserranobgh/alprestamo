module "ec2_alb" {
  source = "./modules/ec2-alb"
  security_groups = module.vpc.security_groups
  priv-main-subnet-cidr = var.priv-main-subnet-cidr
  priv-alt-subnet-cidr = var.priv-alt-subnet-cidr
  pub-main-subnet-cidr = var.pub-main-subnet-cidr
  pub-alt-subnet-cidr = var.pub-alt-subnet-cidr
  codigo-pais = var.codigo-pais
  key_name = var.key_name
  environment = var.environment
  vpc_security_group_ids = module.vpc.security_groups
  certificate_arn = var.certificate_arn
  vpc_id = module.vpc.vpc_id
  dev-priv-main-subnet-id = module.vpc.dev-priv-main-subnet-id
  dev-pub-alt-subnet-id = module.vpc.dev-pub-alt-subnet-id
  dev-pub-main-subnet-id = module.vpc.dev-pub-main-subnet-id
  record_name = var.record_name
  domain_name = var.domain_name
}


module "r53" {
  source = "./modules/r53"
  record_name = var.record_name
  domain_name = var.domain_name
  codigo-pais = var.codigo-pais
  alb_dns_name = module.ec2_alb.alb_dns_name
  alb_hosted_zone_id = module.ec2_alb.alb_hosted_zone_id
  environment = var.environment
  app-dns = module.cdn.app-dns
  front-dns = module.cdn.front-dns
  perf-dns = module.cdn.perf-dns
  app-zone-id = module.cdn.app-zone-id
  front-zone-id = module.cdn.front-zone-id
  perf-zone-id = module.cdn.perf-zone-id
}


module "vpc" {
  source = "./modules/vpc"
  vpc-cidr-block = var.vpc-cidr-block
  priv-main-subnet-cidr = var.priv-main-subnet-cidr
  priv-alt-subnet-cidr = var.priv-alt-subnet-cidr
  pub-main-subnet-cidr = var.pub-main-subnet-cidr
  pub-alt-subnet-cidr = var.pub-alt-subnet-cidr 
  codigo-pais = var.codigo-pais
  az-priv-main = var.az-priv-main
  az-priv-alt = var.az-priv-alt
  az-pub-alt = var.az-pub-alt
  az-pub-main = var.az-pub-main
  environment = var.environment
  cidr-block-cero = var.cidr-block-cero
  gateway-id-a = var.gateway-id-a
  record_name = var.record_name
}

module "s3" {
  source = "./modules/s3"
  environment = var.environment
  record_name = var.record_name
  codigo-pais = var.codigo-pais
  app-identifier = module.cdn.app-identifier
  front-identifier = module.cdn.front-identifier
  perf-identifier = module.cdn.perf-identifier
}

module "cdn" {
  source = "./modules/cdn"
  environment = var.environment
  record_name = var.record_name
  codigo-pais = var.codigo-pais
  origin-id = var.origin-id
  domain-name-app = module.s3.domain-name-app
  domain-name-front = module.s3.domain-name-front
  domain-name-perf = module.s3.domain-name-perf
  acm-certificate-arn = var.acm-certificate-arn
  domain_name = var.domain_name
}

module "rds" {
  source = "./modules/rds"
  dev-priv-alt-subnet-id = module.vpc.dev-priv-alt-subnet-id
  dev-priv-main-subnet-id = module.vpc.dev-priv-main-subnet-id
  environment = var.environment
  codigo-pais = var.codigo-pais
  record_name = var.record_name
  engine-version = var.engine-version
  engine = var.engine
  db-password = var.db-password
  db-instance-class = var.db-instance-class
}