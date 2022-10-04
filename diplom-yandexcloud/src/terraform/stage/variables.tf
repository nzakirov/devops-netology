variable "YC_SERVICE_ACCOUNT_KEY_FILE" {
  description = "Path to YC Account Key File"
  type        = string
}

variable "YC_CLOUD_ID" {
  description = "YC Cloud ID"
  type        = string
}

variable "YC_FOLDER_ID" {
  description = "YC Folder ID"
  type        = string
}

variable "YC_STORAGE_ACCESS_KEY" {
  description = "YC Storage access key"
  type        = string
}

variable "YC_STORAGE_SECRET_KEY" {
  description = "YC Storage secret key"
  type        = string
}

variable "zones" {
  type        = list(string)
  description = "YC zones list"
}

variable "cidr" {
  type        = list(string)
  description = "Nets list"
}

variable "name" {
  type        = list(string)
  description = "Domain names list"
}

variable "hostname" {
  type        = list(string)
  description = "Hostnames list"
}

variable "subdomain" {
  type        = list(string)
  description = "Subdomains list"
}

variable "rproxy_ip" {
  description = "Reversy proxy internal IP"
}

variable "dns_domain" {
  type        = string
  description = "DNS zone"
}
