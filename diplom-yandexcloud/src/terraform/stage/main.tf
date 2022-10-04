provider "yandex" {
  service_account_key_file = var.YC_SERVICE_ACCOUNT_KEY_FILE
  cloud_id                 = var.YC_CLOUD_ID
  folder_id                = var.YC_FOLDER_ID
  zone                     = var.zones[1]
}

resource "yandex_dns_zone" "dns_domain" {
  name   = replace(var.dns_domain, ".", "-")
  zone   = join("", [var.dns_domain, "."])
  public = true
}



