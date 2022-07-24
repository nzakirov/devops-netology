# Network
resource "yandex_vpc_network" "network_terraform" {
  name = "net_terraform"
}
 
resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = terraform.workspace == "prod" ? "subnet-prod" : "subnet-stage"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network_terraform.id}"
  v4_cidr_blocks = terraform.workspace == "prod" ? ["192.168.10.0/24"] : ["192.168.11.0/24"]
}