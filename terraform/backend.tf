#
# Terraform backend. s3 bucket with dynamodb 
#

terraform {
  backend "s3" {
    bucket  = "terraform-tfstate-tmp-files"
    encrypt = true
    key     = "DevOpsCC22/terraform/terraform.tfstate"
    region  = "eu-north-1"
  }
}
