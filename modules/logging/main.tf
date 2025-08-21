# Log bucket
resource "aws_s3_bucket" "logs" {
  bucket = var.bucket_name
  force_destroy = false
  tags = { Project = var.project }
}

resource "aws_s3_bucket_versioning" "v" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# CloudTrail writes policy
data "aws_caller_identity" "current" {}
resource "aws_s3_bucket_policy" "logs_policy" {
  bucket = aws_s3_bucket.logs.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "AWSCloudTrailAclCheck",
        Effect: "Allow",
        Principal: { Service: "cloudtrail.amazonaws.com" },
        Action: "s3:GetBucketAcl",
        Resource: aws_s3_bucket.logs.arn
      },
      {
        Sid: "AWSCloudTrailWrite",
        Effect: "Allow",
        Principal: { Service: "cloudtrail.amazonaws.com" },
        Action: "s3:PutObject",
        Resource: "${aws_s3_bucket.logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        Condition: { StringEquals: { "s3:x-amz-acl": "bucket-owner-full-control" } }
      }
    ]
  })
}

resource "aws_cloudtrail" "main" {
  name                          = "${var.project}-trail"
  s3_bucket_name                = aws_s3_bucket.logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  depends_on                    = [aws_s3_bucket_policy.logs_policy]
}
