output "domain-name-app" {
    value = aws_s3_bucket.app.bucket_regional_domain_name
}

output "domain-name-front" {
    value = aws_s3_bucket.front.bucket_regional_domain_name
}

output "domain-name-perf" {
    value = aws_s3_bucket.perf.bucket_regional_domain_name
}