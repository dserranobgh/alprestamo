# Create origin access control & Identity

resource "aws_cloudfront_origin_access_control" "origin" {
  name = var.origin-id
  description = "alprestamo origin access control"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

resource "aws_cloudfront_origin_access_identity" "app" {
  comment = var.domain-name-app
}

resource "aws_cloudfront_origin_access_identity" "front" {
  comment = var.domain-name-front
}

resource "aws_cloudfront_origin_access_identity" "perf" {
  comment = var.domain-name-perf
}




# Create bucket distributions

resource "aws_cloudfront_distribution" "app-distibution" {

  price_class = "PriceClass_All"
    origin {
      domain_name = var.domain-name-app
      origin_id = "${var.record_name}-${var.codigo-pais}-${var.environment}-app"
      s3_origin_config {
        origin_access_identity = aws_cloudfront_origin_access_identity.app.cloudfront_access_identity_path
      }
    }

    custom_error_response {
      error_caching_min_ttl = 10
      error_code = 403
      response_code = 200
      response_page_path = "/index.html"
    }

    custom_error_response {
      error_caching_min_ttl = 10
      error_code = 404
      response_code = 200
      response_page_path = "/index.html"
    }

    enabled = true
    is_ipv6_enabled = true
    comment = "${var.record_name}-${var.codigo-pais}-${var.environment}-app"
    default_root_object = ""

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "${var.record_name}-${var.codigo-pais}-${var.environment}-app"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
        }
      }
  viewer_protocol_policy = "redirect-to-https"
  min_ttl = 0
  default_ttl = 3600
  max_ttl = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  viewer_certificate {
    acm_certificate_arn = var.acm-certificate-arn
    ssl_support_method = "sni-only"
  }

  aliases = ["app-${var.record_name}-${var.codigo-pais}.${var.domain_name}"]

}



resource "aws_cloudfront_distribution" "front-distibution" {

  price_class = "PriceClass_All"
    origin {
      domain_name = var.domain-name-front
      origin_id = "${var.record_name}-${var.codigo-pais}-${var.environment}-front"
      s3_origin_config {
        origin_access_identity = aws_cloudfront_origin_access_identity.front.cloudfront_access_identity_path
      }
    }

    custom_error_response {
      error_caching_min_ttl = 10
      error_code = 403
      response_code = 200
      response_page_path = "/index.html"
    }

    custom_error_response {
      error_caching_min_ttl = 10
      error_code = 404
      response_code = 200
      response_page_path = "/index.html"
    }

    enabled = true
    is_ipv6_enabled = true
    comment = "${var.record_name}-${var.codigo-pais}-${var.environment}-front"
    default_root_object = ""
  

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "${var.record_name}-${var.codigo-pais}-${var.environment}-front"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
        }
      }
  viewer_protocol_policy = "redirect-to-https"
  min_ttl = 0
  default_ttl = 3600
  max_ttl = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  viewer_certificate {
    acm_certificate_arn = var.acm-certificate-arn
    ssl_support_method = "sni-only"
  }

  aliases = ["${var.record_name}-${var.codigo-pais}.${var.domain_name}"]

}


resource "aws_cloudfront_distribution" "perf-distibution" {

  price_class = "PriceClass_All"
    origin {
      domain_name = var.domain-name-perf
      #origin_access_control_id = aws_cloudfront_origin_access_control.origin.id
      origin_id = "${var.record_name}-${var.codigo-pais}-${var.environment}-perf"
      s3_origin_config {
        origin_access_identity = aws_cloudfront_origin_access_identity.perf.cloudfront_access_identity_path
      }
    }

    custom_error_response {
      error_caching_min_ttl = 10
      error_code = 403
      response_code = 200
      response_page_path = "/index.html"
    }

    custom_error_response {
      error_caching_min_ttl = 10
      error_code = 404
      response_code = 200
      response_page_path = "/index.html"
    }

    enabled = true
    is_ipv6_enabled = true
    comment = "${var.record_name}-${var.codigo-pais}-${var.environment}-perf"
    default_root_object = ""

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "${var.record_name}-${var.codigo-pais}-${var.environment}-perf"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
        }
      }
  viewer_protocol_policy = "redirect-to-https"
  min_ttl = 0
  default_ttl = 3600
  max_ttl = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  viewer_certificate {
    acm_certificate_arn = var.acm-certificate-arn
    ssl_support_method = "sni-only"
  }

  aliases = ["p-${var.record_name}-${var.codigo-pais}.${var.domain_name}"]

}