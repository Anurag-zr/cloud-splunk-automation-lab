output "cloudtrail_bucket_name" {
  value = module.cloudtrail.cloudtrail_bucket_name
}
output "cloudtrail_bucket_arn" {
  value = module.cloudtrail.cloudtrail_bucket_arn
}

output "cloudtrail_name" {
    value = module.cloudtrail.cloudtrail_name
}


output "guardduty_bucket_name" {
  description = "Name of the GuardDuty findings S3 bucket"
  value       = length(module.guardDuty) > 0 ? module.guardDuty[0].guardduty_bucket_name : null
}

output "guardduty_detector_id" {
  description = "ID of the GuardDuty detector"
  value       = length(module.guardDuty) > 0 ? module.guardDuty[0].guardduty_detector_id : null
}

output "centralized_logs_bucket_name" {
  value = module.aws_centralized_logging.centralized_logs_bucket_name
}

output "centralized_logs_bucket_arn" {
  value = module.aws_centralized_logging.centralized_logs_bucket_arn
}