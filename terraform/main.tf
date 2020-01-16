# Simple AWS Lambda Terraform Example

terraform {
  required_version = ">= 0.12"

  backend "remote" {
    organization = "techanvil"

    workspaces {
      name = "test-foo"
    }
  }
}

variable "aws_region" {
  default = "us-west-2"
}

provider "aws" {
  region = "${var.aws_region}"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../dist/index.js"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "test_lambda"
  role             = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler          = "index.handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "nodejs12.x"
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name               = "iam_for_lambda_tf"
  assume_role_policy = data.aws_iam_policy_document.lambda_arp.json
}

data "aws_iam_policy_document" "lambda_arp" {
  statement {
    sid     = "AllowLambda"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
