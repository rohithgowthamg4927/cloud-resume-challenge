resource "aws_lambda_function" "cloud_resume_lambda" {
  function_name    = "cloud-resume"
  filename         = "${path.module}/lambda/lambda_function.zip"
  role             = "arn:aws:iam::767398004714:role/service-role/cloud-resume-role-duln3xu8"
  source_code_hash = filebase64sha256("${path.module}/lambda/lambda_function.zip")
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
}


data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_function.py"
  output_path = "${path.module}/lambda/lambda_function.zip"
}
