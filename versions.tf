/*
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0"
    }
  }

  required_version = ">= 0.14"
}
*/
terraform {

# version constraints
  required_providers {
    local      = ">= 1.4"
    random     = ">= 2.1"
    kubernetes = ">= 1.18, <= 1.20"
  }
  required_version = ">= 0.14"
}