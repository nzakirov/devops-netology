terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "s3-nzakirov-netology"
    region = "ru-central1"
    key = "terraform/terraform.tfstate"

    skip_region_validation = true
    skip_credentials_validation = true
  }
}
