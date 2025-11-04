

# Create S3 bucket for centralized logging
resource "aws_s3_bucket" "centralized_logs" {
  bucket        = var.centralized_log_bucket_name
  force_destroy = true

  tags = merge(
    { Name = "aws-centralized-logs" },
    var.common_tags
  )
}

# Enable server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.centralized_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.centralized_logs.id
  versioning_configuration { status = "Enabled" }
}

# Set lifecycle policy to transition logs to Glacier after 90 days and expire after 365 days
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.centralized_logs.id
  rule {
    id     = "archive-logs"
    status = "Enabled"
    transition {
      days          = 90
      storage_class = "GLACIER"
    }
    expiration { days = 365 }
  }
}


#  Bucket Policy to allow multiple AWS log services to deliver logs
resource "aws_s3_bucket_policy" "centralized_logging_policy" {
  bucket = aws_s3_bucket.centralized_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # VPC Flow Logs
      {
        Sid = "AllowVPCFlowLogsDelivery"
        Effect = "Allow"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
        Action = [
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.centralized_logs.arn}/vpcflow/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },

      # CloudFront, ELB, API Gateway logs (if added later)
      {
        Sid = "AllowOtherAWSServiceLogs"
        Effect = "Allow"
        Principal = {
          Service = [
            "cloudfront.amazonaws.com",
            "elasticloadbalancing.amazonaws.com",
            "apigateway.amazonaws.com",
            "rds.amazonaws.com"
          ]
        }
        Action = "s3:PutObject"
        Resource = [
          "${aws_s3_bucket.centralized_logs.arn}/cloudfront/*",
          "${aws_s3_bucket.centralized_logs.arn}/elb/*",
          "${aws_s3_bucket.centralized_logs.arn}/apigw/*",
          "${aws_s3_bucket.centralized_logs.arn}/rds/*"
        ]
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },

      # Required for AWS services to verify ACL
      {
        Sid = "AllowServiceGetBucketAcl"
        Effect = "Allow"
        Principal = {
          Service = [
            "delivery.logs.amazonaws.com",
            "cloudfront.amazonaws.com",
            "elasticloadbalancing.amazonaws.com",
            "apigateway.amazonaws.com",
            "rds.amazonaws.com"
          ]
        }
        Action = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.centralized_logs.arn
      }
    ]
  })
}


module "vpcflow_logging" {
  source = "./vpcflow"
  centralized_log_bucket_arn = aws_s3_bucket.centralized_logs.arn
}

# module "elb_logging" {
#   source = "./elb.tf"
# }

# module "cloudfornt_logging" {
#   source = "./cloudfront.tf"
# }

# module "apiGW_logging" {
#   source = "./apiGW.tf"
# }



