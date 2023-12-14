# Create S3 buckets

resource "aws_s3_bucket" "app" {
    bucket = "${var.record_name}-${var.codigo-pais}-${var.environment}-app"

    tags = {
      Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-app"
    }
  
}

resource "aws_s3_bucket" "front" {
    bucket = "${var.record_name}-${var.codigo-pais}-${var.environment}-front"
    

    tags = {
      Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-front"
    }
  
}

resource "aws_s3_bucket_website_configuration" "front" {
  bucket = aws_s3_bucket.front.bucket
  index_document {
    suffix = "index.html"

  }
}

resource "aws_s3_bucket" "perf" {
    bucket = "${var.record_name}-${var.codigo-pais}-${var.environment}-perf"

    tags = {
      Name = "${var.record_name}-${var.codigo-pais}-${var.environment}-perf"
    }
  
}

# Create bucket policies

resource "aws_s3_bucket_policy" "allow_access_app" {
  bucket = aws_s3_bucket.app.id
  policy = data.aws_iam_policy_document.allow_access_app.json
}

resource "aws_s3_bucket_policy" "allow_access_front" {
  bucket = aws_s3_bucket.front.id
  policy = data.aws_iam_policy_document.allow_access_front.json
}

resource "aws_s3_bucket_policy" "allow_access_perf" {
  bucket = aws_s3_bucket.perf.id
  policy = data.aws_iam_policy_document.allow_access_perf.json
}

data "aws_iam_policy_document" "allow_access_app" {
  policy_id = "PoliciForCloudFrontPrivateContent"

  statement {
    sid = "AllowCloudFrontServicePrincipal"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.app.arn}/*"]

    principals {
      type = "AWS"
      identifiers = ["${var.app-identifier}"]
    }
  }
}

data "aws_iam_policy_document" "allow_access_front" {
  policy_id = "PoliciForCloudFrontPrivateContent"

  statement {
    sid = "AllowCloudFrontServicePrincipal"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.front.arn}/*"]

    principals {
      type = "AWS"
      identifiers = ["${var.front-identifier}"]
    }
  }
}

data "aws_iam_policy_document" "allow_access_perf" {
  policy_id = "PoliciForCloudFrontPrivateContent"

  statement {
    sid = "AllowCloudFrontServicePrincipal"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.perf.arn}/*"]

    principals {
      type = "AWS"
      identifiers = ["${var.perf-identifier}"]
    }
  }
}