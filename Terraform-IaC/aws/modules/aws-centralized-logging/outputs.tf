output "centralized_logs_bucket_name" {
  value = aws_s3_bucket.centralized_logs.bucket
}

output "centralized_logs_bucket_arn" {
  value = aws_s3_bucket.centralized_logs.arn
}

output "vpc_flow_log_id" {
  value = module.vpcflow_logging.vpc_flow_log_id
}
