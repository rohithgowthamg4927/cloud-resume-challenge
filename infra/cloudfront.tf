resource "aws_cloudfront_distribution" "csr_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for Cloud Resume Challenge"
  default_root_object = "index.html"

  origin {
    domain_name = "cloud-resume-challenge-4927.s3.ap-south-1.amazonaws.com"
    origin_id   = "S3-cloud-resume-challenge-4927"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.csr_origin_access_identity.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-cloud-resume-challenge-4927"
    viewer_protocol_policy = "https-only"

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["HEAD", "GET", "OPTIONS"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:767398004714:certificate/f1a63636-261e-405c-8b6b-4d4b9e686ed7"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  aliases = ["resume.rohithgowthamg.cloud"]

  tags = {
    project = "cloud resume challenge"
  }
}

resource "aws_cloudfront_origin_access_identity" "csr_origin_access_identity" {
  comment = "Origin Access Identity for CloudFront Distribution"
}
