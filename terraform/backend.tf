terraform {
  backend "s3" {
    bucket  = "tf-state-sako"
    key     = "dev/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
