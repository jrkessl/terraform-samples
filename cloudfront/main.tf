# private bucket 
resource "aws_s3_bucket" "example" {
  bucket = "${var.ticket}-${var.project_name}-bucket"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
}