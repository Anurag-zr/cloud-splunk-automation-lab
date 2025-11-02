output "guardduty_bucket_name" {
  description = "Name of the S3 bucket where GuardDuty findings are exported"
  value       = aws_s3_bucket.guardDuty_logs.bucket
}

output "guardduty_detector_id" {
  description = "ID of the GuardDuty detector"
  value       = aws_guardduty_detector.guardDuty_detector.id
}