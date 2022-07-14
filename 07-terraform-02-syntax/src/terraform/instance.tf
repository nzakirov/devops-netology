data "yandex_compute_image" "ubuntu_image" {
    family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm-1" {
    name = "vm-1"
    allow_stopping_for_update = true

    resources {
        cores =1
        memory = 1
    }
  
  boot_disk {
    initialize_params {
        image_id = data.yandex_compute_image.ubuntu_image.id
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