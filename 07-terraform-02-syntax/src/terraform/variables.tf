variable "yandex_token" {
  description = "Yandex Cloud OAuth-token "
  type        = string
}

variable "yandex_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yandex_folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
  default     = "ru-central1-a"
}
