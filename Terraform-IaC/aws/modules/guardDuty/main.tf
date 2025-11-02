resource "aws_s3_bucket" "guardDuty_logs" {
  bucket = var.guardDuty_s3_bucket_name
  force_destroy = true

  tags = merge(
    { Name = "guardDuty-logs-bucket" },
    var.common_tags
  )
}

resource "aws_s3_bucket_lifecycle_configuration" "guardDuty_logs_life_cycle" {
  bucket = aws_s3_bucket.guardDuty_logs.id

  rule {
    id     = "guardDuty-log-archive"
    status = "Enabled"

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "guardDuty_logs_encryptiong" {
    bucket = aws_s3_bucket.guardDuty_logs.id
  
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
}

resource "aws_s3_bucket_versioning" "guardDuty_logs_versioning" {
  bucket = aws_s3_bucket.guardDuty_logs.id

  versioning_configuration {
    status = "Enabled"
  }
  
}

resource "aws_s3_bucket_policy" "guardDuty_logs_bucket_policy" {
  bucket = aws_s3_bucket.guardDuty_logs.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Sid    = "AllowGuardDutyToPutObjects",
        Effect = "Allow",
        Principal = {
            Service = "guardduty.amazonaws.com"
        },
        Action = "s3:PutObject",
        Resource = "${aws_s3_bucket.guardDuty_logs.arn}/*"
        }
    ]
  })
}

# Create the GuardDuty detector (enables GuardDuty)
resource "aws_guardduty_detector" "guardDuty_detector" {
  enable = true
  finding_publishing_frequency = var.guardDuty_finding_publishing_frequency
  tags= merge(
    { Name = "guardDuty-detector" },
    var.common_tags
  )
}

# Export GuardDuty findings to S3 bucket
resource "aws_guardduty_publishing_destination" "this" {
  detector_id     = aws_guardduty_detector.guardDuty_detector.id
  destination_arn = aws_s3_bucket.guardDuty_logs.arn
  destination_type = "S3"
  kms_key_arn = aws_kms_key.guardduty_kms_key.arn

  depends_on = [aws_s3_bucket.guardDuty_logs, aws_kms_key.guardduty_kms_key]
}


resource "aws_kms_key" "guardduty_kms_key" {
    description             = "KMS key for GuardDuty findings S3 bucket"
    deletion_window_in_days = 7
    policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Sid    = "Enable IAM User Permissions",
        Effect = "Allow",
        Principal = {
            AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*",
        Resource = "*"
        },
        {
        Sid = "Allow GuardDuty to encrypt and decrypt",
        Effect = "Allow",
        Principal = {
            Service = "guardduty.amazonaws.com"
        },
        Action = [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
        ],
        Resource = "*"
        }
    ]
    })
}

data "aws_caller_identity" "current" {}

