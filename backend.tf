terraform {
  backend "s3" {
    region = "ap-south-1"
    bucket = "datastorebucket"
    key = "terraform.state"
  }
}

