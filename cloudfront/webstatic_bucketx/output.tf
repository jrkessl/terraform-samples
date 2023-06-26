output "bucket" {
  description = "The website bucket"
  value       = aws_s3_bucket.this.bucket
}

output "id" {
  description = "The id bucket"
  value       = aws_s3_bucket.this.id
}

output "arn" {
  description = "The arn bucket"
  value       = aws_s3_bucket.this.arn
}
