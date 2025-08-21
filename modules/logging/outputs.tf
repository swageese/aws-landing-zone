output "cloudtrail_arn" { value = aws_cloudtrail.main.arn }
output "log_bucket"     { value = aws_s3_bucket.logs.id }
