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

# variable "yandex_access_key" {
#   description = "Yandex Cloud access key"
#   type        = string
# }

# variable "yandex_secret_key" {
#   description = "Yandex Cloud secret key"
#   type        = string
# }