resource "aws_s3_bucket" "csr_bucket" {
  bucket = "cloud-resume-challenge-4927"

  tags = {
    project = "cloud resume challenge"
  }
}

# resource "aws_s3_bucket_acl" "csr_bucket_acl" {
#   bucket = aws_s3_bucket.csr_bucket.id
#   acl    = "private"
# }

resource "aws_s3_bucket_public_access_block" "csr_bucket_public_access_block" {
  bucket = aws_s3_bucket.csr_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_policy" "csr_bucket_policy" {
  bucket = aws_s3_bucket.csr_bucket.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "PolicyForCloudFrontPrivateContent",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipal",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::cloud-resume-challenge-4927/*",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceArn" : "arn:aws:cloudfront::767398004714:distribution/E1EHL7AW0FLLUL"
          }
        }
      }
    ]
  })
}
