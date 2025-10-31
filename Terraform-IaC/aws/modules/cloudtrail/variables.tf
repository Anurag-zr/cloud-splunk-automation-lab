variable "cloudtrail_bucket_name" {
  description = "S3 bucket name for CloudTrail logs"
  type        = string
}

variable "tags" {

  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    Project   = "Cloud-Splunk-Automation"
    ManagedBy = "Terraform"
    Owner     = "Anurag"
    Env       = "Dev"
  }

}

variable "cloudtrail_name" {
    description = "Name of the CloudTrail"
    type = string
    default = "security-cloudtrail"
  
}