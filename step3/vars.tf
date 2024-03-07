
variable "region" {
  type        = string
  description = "AWS region"
  default     = "no-region"
}

variable "aws_access_key_id" {
  type        = string
  description = "AWS_ACCESS_KEY_ID"
  default     = "no-aws_access_key_id"
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS_SECRET_ACCESS_KEY"
  default     = "no-aws_secret_access_key"
}
