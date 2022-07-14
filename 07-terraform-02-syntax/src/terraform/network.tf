# Network
resource "yandex_vpc_network" "network_terraform" {
  name = "net_terraform"
}
 
resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "sub_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}