provider "aws" {
  region = var.region

  default_tags {
    tags = {
      owner        = "Alex Shydlovskyi"
      cluster_name = "${local.cluster_name}"
      email        = "skiyl9x@gmail.com"
      project      = "DevOps_CC2022"
      reason       = "education"
      environment  = "${var.environment_name}"
    }
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}


locals {
  cluster_name = "cc22-eks-${random_string.suffix.result}"
}
