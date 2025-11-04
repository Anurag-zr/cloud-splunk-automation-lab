# resource "aws_s3_bucket" "test_bucket" {
#     bucket = "splunk-terraform-test-bucket-${random_id.suffix.hex}" 
# }

resource "random_id" "suffix" {
  byte_length = 4
}


module "cloudtrail" {
  source = "./modules/cloudtrail"
  cloudtrail_bucket_name = "cloudtrail-logs-${random_id.suffix.hex}"
}


module "guardDuty" {
  count = var.enable_guardDuty?1:0
  source = "./modules/guardDuty"  
  guardDuty_s3_bucket_name = "guardduty-logs-${random_id.suffix.hex}"
}

module "aws_centralized_logging" {
  source = "./modules/aws-centralized-logging" 
  centralized_log_bucket_name = "centralized-logs-${random_id.suffix.hex}"
}