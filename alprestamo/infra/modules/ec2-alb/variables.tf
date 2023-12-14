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

variable "record_name" {
  type = string
}

variable "vpc_security_group_ids" {
    type = any
}

variable "security_groups" {
    type = string
}

variable "certificate_arn" {
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

variable "codigo-pais" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "dev-priv-main-subnet-id" {
    type = string
}

variable "dev-pub-alt-subnet-id" {
    type = string
    }

variable "dev-pub-main-subnet-id" {
  type = string
}

variable "configuration" {
  description = "The total configuration, List of Objects/Dictionary"
  default = [
    {
    "application_name" : "app-lando",
    "ami" : "ami-0cbd40f694b804622",
    "no_of_instances" : "1",
    "instance_type" : "t2.micro",
  },
  {
    "application_name" : "app-checo",
    "ami" : "ami-0cbd40f694b804622",
    "instance_type" : "t2.micro",
    "no_of_instances" : "1"
  },
  {
    "application_name" : "app-lewis",
    "ami" : "ami-0cbd40f694b804622",
    "instance_type" : "t2.micro",
    "no_of_instances" : "1"
  }
  ]
}

variable "domain_name" {
  type = string
}