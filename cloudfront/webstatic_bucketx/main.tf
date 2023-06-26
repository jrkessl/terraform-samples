resource "aws_s3_bucket" "this" {
  bucket        = var.domain_name
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = var.acl
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
}