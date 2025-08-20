resource "aws_s3_bucket" "logs" {
  bucket = "hemanth-landingzone-logs"
}

resource "aws_cloudtrail" "main" {
  name                          = "hemanth-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.logs.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
}
