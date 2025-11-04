
# Create IAM Role for VPC Flow Logs
# resource "aws_iam_role" "vpc_flow_logs_role" {
#   name = "vpc-flow-logs-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Principal = { Service = "vpc-flow-logs.amazonaws.com" },
#       Action = "sts:AssumeRole"
#     }]
#   })
# }

# Attach policy to allow VPC Flow Logs to write to S3 bucket
# resource "aws_iam_role_policy" "vpc_flow_logs_policy" {
#   name = "vpc-flow-logs-policy"
#   role = aws_iam_role.vpc_flow_logs_role.id
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Action = ["s3:PutObject"],
#       Resource = "arn:aws:s3:::${var.centralized_log_bucket_name}/vpcflow/*"
#     }]
#   })
# }

# Fetch default VPC dynamically
data "aws_vpc" "default" {
  default = true
}


# Create VPC Flow Logs
resource "aws_flow_log" "vpc_flow_log" {
  log_destination      = "${var.centralized_log_bucket_arn}/vpcflow/"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = data.aws_vpc.default.id
#  iam_role_arn         = aws_iam_role.vpc_flow_logs_role.arn
  
}