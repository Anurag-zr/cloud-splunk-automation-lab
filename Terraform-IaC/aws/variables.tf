variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "us-east-1"
  
}


#guardDuty enabled variable 

variable "enable_guardDuty" {
  description = "Enable or disable GuardDuty provisioning"
  type        = bool
  default     = false
}