################### EC2 variables ###################

variable "ami" {
  type = string
}

variable "checo-ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "vpc_security_group_ids" {
  type = any
}

variable "vpc_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "configuration" {
  description = "The total configuration, List of Objects/Dictionary"
  default = [{}]
}


#variable "private_key_path" {}

################### Route 53 variables ###################

variable "domain_name" {
  type = string
}

variable "record_name" {
  type = string
}

################### VPC Variables ###################

variable "vpc-cidr-block" {
  type = string
}

variable "codigo-pais" {
    type = string
}

variable "environment" {
  type = string
}

variable "pub-main-subnet-cidr" {
  type = string
}

variable "pub-alt-subnet-cidr" {
  type = string
}

variable "priv-main-subnet-cidr" {
  type = string
}

variable "priv-alt-subnet-cidr" {
  type = string
}

variable "az-pub-main" {
  type = string
}

variable "az-pub-alt" {
  type = string
}

variable "az-priv-main" {
  type = string
}

variable "az-priv-alt" {
  type = string
}

variable "gateway-id-a" {
  type = string
}

variable "cidr-block-cero" {
  type = string
}



################### CDN Variables ###################

variable "origin-id" {
  type = string
}

variable "acm-certificate-arn" {
  type = string
}
