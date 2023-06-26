output "cfn_id" {
  description = "The CFN ID"
  value       = aws_cloudfront_distribution.this.id
}

output "cfn_domain_name" {
  description = "The CFN Domain Name"
  value       = aws_cloudfront_distribution.this.domain_name
}
