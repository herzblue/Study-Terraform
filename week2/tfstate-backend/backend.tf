provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "ygpark-s3bucket" {
  bucket = "ygpark-t101study-tfstate"
}

# Enable versioning so you can see the full revision history of your state files
resource "aws_s3_bucket_versioning" "ygpark-s3bucket_versioning" {
  bucket = aws_s3_bucket.ygpark-s3bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.ygpark-s3bucket.arn
  description = "The ARN of the S3 bucket"
}
