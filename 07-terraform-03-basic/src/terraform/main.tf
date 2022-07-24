terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  #required_version = "=0.84.0"

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    #dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gdkem0mim4so5c0stp/etni3dtrie6rcddskm00"
    bucket = "terraform-state-nz"
    #dynamodb_table = "tf_lock"
    region = "ru-central1"
    key = "terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
    #access_key = "${var.yandex_access_key}"
    #secret_key = "${var.yandex_secret_key}"
    
  } 
}

provider "yandex" {
  token     = "${var.yandex_token}"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
  zone      = "ru-central1-a"
}
