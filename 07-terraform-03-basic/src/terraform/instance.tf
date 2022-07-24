data "yandex_compute_image" "ubuntu_image" {
    family = "ubuntu-2004-lts"
}

# resource "yandex_compute_instance" "node" {
#     name                      = terraform.workspace == "prod" ? "node${count.index}-prod" : "node${count.index}-stage"
#     zone                      = "ru-central1-a"
#     hostname                  = terraform.workspace == "prod" ? "node${count.index}-prod.netology.yc" : "node${count.index}-stage.netology.yc"
#     allow_stopping_for_update = true
#     count = terraform.workspace == "prod" ? 2 : 1

#     resources {
#       cores  = terraform.workspace == "prod" ? 2 : 1
#       memory = terraform.workspace == "prod" ? 2 : 1
#     }

resource "yandex_compute_instance" "node-foreach" {
  for_each = toset(terraform.workspace == "prod" ? ["node01","node02"] : ["node01"])
  name                      = "${each.value}-${terraform.workspace == "prod" ? "prod" : "stage"}"
  zone                      = "ru-central1-a"
  hostname                  = "${each.value}-${terraform.workspace == "prod" ? "prod" : "-stage"}.netology.yc"
  allow_stopping_for_update = true

  lifecycle {
    create_before_destroy = true
  }

  resources {
    cores  = 2
    memory = 2
  }
  
  boot_disk {
    initialize_params {
        image_id = data.yandex_compute_image.ubuntu_image.id
        # type        = "network-nvme"
        # size        = "10"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
    ssh-authorized-keys = "test1:${file("~/.ssh/id_rsa.pub")}"

  }
}