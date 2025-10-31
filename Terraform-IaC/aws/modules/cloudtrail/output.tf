output "cloudtrail_bucket_name" {
  description = "Name of the S3 cloudtrail bucket"
  value = aws_s3_bucket.cloudtrail_logs.id
}

output "cloudtrail_bucket_arn" {
  description = "ARN of the cloudtrail S3 bucket"
  value = aws_s3_bucket.cloudtrail_logs.arn
}

output "cloudtrail_name" {
    description = "Name of the CloudTrail"
    value = aws_cloudtrail.security_trail.name
  
}