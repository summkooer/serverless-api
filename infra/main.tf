terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}
provider "aws" {
  shared_config_files = [var.shared_config_files]
  shared_credentials_files =  [var.shared_credentials_files]
  default_tags{
    tags = var.tags
  }
}

variable "app_name" {
  description = "Application name"
  default     = "test-lambda-api"
}

variable "app_env" {
  description = "Application environment tag"
  default     = "dev"
}

locals {
  app_id = "${lower(var.app_name)}-${lower(var.app_env)}-${random_id.unique_suffix.hex}"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../build/bin/app"
  output_path = "build/bin/app.zip"
}

resource "random_id" "unique_suffix" {
  byte_length = 2
}

output "api_url" {
  value = aws_api_gateway_deployment.api_deployment.invoke_url
}