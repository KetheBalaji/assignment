provider "aws" {
  access_key = "AKIAZI2LIQHI7AB6RLM7"
  secret_key = "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"
  region = var.aws_region
}
terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 4.0"
   }
 }
}