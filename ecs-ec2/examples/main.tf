provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}

module "template" {
  source = "../"
}
