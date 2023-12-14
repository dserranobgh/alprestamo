
# terraform aws data hosted zone
data "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

# create a record set in route 53

resource "aws_route53_record" "app-record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "app-${var.record_name}-${var.codigo-pais}"
  type    = "CNAME"

  alias {
    name                   = var.app-dns
    evaluate_target_health = true
    zone_id = var.app-zone-id
  }
}

resource "aws_route53_record" "front-end-record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "${var.record_name}-${var.codigo-pais}"
  type    = "CNAME"

  alias {
    name                   = var.front-dns
    evaluate_target_health = true
    zone_id = var.front-zone-id
  }
}

resource "aws_route53_record" "perf-record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "p-${var.record_name}-${var.codigo-pais}"
  type    = "CNAME"

  alias {
    name                   = var.perf-dns
    evaluate_target_health = true
    zone_id = var.perf-zone-id
  }
}

resource "aws_route53_record" "lando-record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "${var.record_name}-lando-${var.environment}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "checo-record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "${var.record_name}-checo-${var.environment}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "lewis-record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "${var.record_name}-lewis-${var.environment}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_hosted_zone_id
    evaluate_target_health = true
  }
}