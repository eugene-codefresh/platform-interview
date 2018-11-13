provider "aws" {
  version = "~> 1.38"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

provider "template" {
  version = "~> 1.0"
}