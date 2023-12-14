output "app-dns" {
  value = aws_cloudfront_distribution.app-distibution.domain_name
}

output "front-dns" {
  value = aws_cloudfront_distribution.front-distibution.domain_name
}

output "perf-dns" {
  value = aws_cloudfront_distribution.perf-distibution.domain_name
}

output "app-zone-id" {
  value = aws_cloudfront_distribution.app-distibution.hosted_zone_id
}

output "front-zone-id" {
  value = aws_cloudfront_distribution.front-distibution.hosted_zone_id
}

output "perf-zone-id" {
  value = aws_cloudfront_distribution.perf-distibution.hosted_zone_id
}

output "app-identifier" {
  value = aws_cloudfront_origin_access_identity.app.iam_arn
  
}

output "front-identifier" {
  value = aws_cloudfront_origin_access_identity.front.iam_arn
  
}

output "perf-identifier" {
  value = aws_cloudfront_origin_access_identity.perf.iam_arn
  
}