terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.75.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.YC_SERVICE_ACCOUNT_KEY_FILE
  cloud_id                 = var.YC_CLOUD_ID
  folder_id                = var.YC_FOLDER_ID
  zone                     = "ru-central1-a"
}

resource "yandex_storage_bucket" "s3" {
  access_key    = var.YC_STORAGE_ACCESS_KEY
  secret_key    = var.YC_STORAGE_SECRET_KEY
  bucket        = "s3-nzakirov-netology"
  force_destroy = true
}
