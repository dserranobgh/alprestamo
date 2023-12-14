variable "domain_name" {
    type = string
}
variable "record_name" {
    type = string
}
variable "codigo-pais" {
    type = string
}
variable "alb_dns_name" {
    type = string
}
variable "alb_hosted_zone_id" {
    type = string
}
variable "environment" {
    type = string
}

variable "app-dns" {
  type = string
}

variable "front-dns" {
  type = string
}

variable "perf-dns" {
  type = string
}

variable "app-zone-id" {
  type = string
}

variable "front-zone-id" {
  type = string
}

variable "perf-zone-id" {
  type = string
}