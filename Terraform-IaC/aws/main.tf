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