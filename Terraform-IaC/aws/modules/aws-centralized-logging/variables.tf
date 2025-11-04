variable "common_tags" {

  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    Project   = "Cloud-Splunk-Automation"
    ManagedBy = "Terraform"
    Owner     = "Anurag"
    Env       = "Dev"
  }

}

variable "centralized_log_bucket_name" {
  description = "Name of the S3 bucket to store centralized logs"
  type        = string
  
}

