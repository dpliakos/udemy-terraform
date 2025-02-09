output "s3_bucket_name" {
  value       = aws_s3_bucket.project_bucket.bucket
  description = "The name of the S3 bucket"
  sensitive   = true
}

output "sensitive_var" {
  value     = var.my_sensitive_value
  sensitive = true
}
