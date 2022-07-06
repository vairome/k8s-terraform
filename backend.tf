terraform {
  backend "s3" {
    bucket = "vairome-terraform-state-k8s-app"
    key    = "terraform/k8s-app"
    region = "us-east-1"
  }
}