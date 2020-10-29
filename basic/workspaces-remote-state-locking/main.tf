provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket         = "denis-aws-terraform-968339500772-us-east-1-remote-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "denis-aws-terraform-968339500772-us-east-1-remote-state"
  }
}

locals {
  env = "${terraform.workspace}"
}

resource "aws_instance" "web" {
  ami           = "${lookup(var.ami, local.env)}"
  instance_type = "${lookup(var.type, local.env)}"

  tags = {
    Name = "My web machine ${local.env}"
    Env  = "${local.env}"
  }
}
