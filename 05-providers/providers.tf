terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0   "
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east"
}

resource "aws_s3_bucket" "eu_central_1" {
  bucket = "some-random-bucket-name-fflkdjfafhkasdfdask"
}

resource "aws_s3_bucket" "us_east_1" {
  bucket   = "some-random-bucket-name-da3iouy8opcvndsm"
  provider = aws.us-east
}
