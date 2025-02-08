terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "tf-test-s3-backend-01"
    key    = "04-backends/state.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"

}
