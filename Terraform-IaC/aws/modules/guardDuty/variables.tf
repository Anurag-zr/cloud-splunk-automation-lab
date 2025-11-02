variable "guardDuty_s3_bucket_name" {
  description = "The name of the S3 bucket to store GuardDuty logs"
  type        = string
  
}

variable "common_tags" {
  description = "Tages applied to all guardDuty securtiy logs resources"
  type =  map(string)
  default = {
    "Project" = "Cloud-Splunk-Automation"
    "ManagedBy" = "Terraform"
    "Owner" = "Anurag"
    "Env" = "Dev"
  }
}

variable "guardDuty_finding_publishing_frequency" {
  description = "How frequently findings are published (FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS)"
  type        = string
  default     = "FIFTEEN_MINUTES"
}