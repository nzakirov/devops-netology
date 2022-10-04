resource "yandex_compute_instance" "rproxy" {
  name     = "proxy"
  hostname = "nzakirov.ru"
  zone     = var.zones[0]

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd83slullt763d3lo57m" // nat-instance-ubuntu-18-04-lts-v20220829 
      type     = "network-hdd"
      size     = "10"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet[0].id
    ip_address = var.rproxy_ip
    nat        = true
    ipv6       = false
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
    #    ssh-keys  = "virtops:${file("~/.ssh/id_rsa_yc.pub")}"
  }
}

resource "yandex_compute_instance" "app" {
  name     = "app"
  hostname = "app.nzakirov.ru"
  zone     = var.zones[0]

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3" // ubuntu-20-04-lts-v20220822   
      type     = "network-hdd"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[0].id
    ipv6      = false
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
resource "yandex_compute_instance" "db01" {
  name     = "db01"
  hostname = "db01.nzakirov.ru"
  zone     = var.zones[1]

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3" // ubuntu-20-04-lts-v20220822   
      type     = "network-hdd"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[1].id
    ipv6      = false
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

resource "yandex_compute_instance" "db02" {
  name     = "db02"
  hostname = "db02.nzakirov.ru"
  zone     = var.zones[2]

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3" // ubuntu-20-04-lts-v20220822   
      type     = "network-hdd"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[2].id
    ipv6      = false
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

resource "yandex_compute_instance" "gitlab" {
  name     = "gitlab"
  hostname = "gitlab.nzakirov.ru"
  zone     = var.zones[1]

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3" // ubuntu-20-04-lts-v20220822   
      type     = "network-hdd"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[1].id
    ipv6      = false
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

resource "yandex_compute_instance" "monitoring" {
  name     = "monitoring"
  hostname = "monitoring.nzakirov.ru"
  zone     = var.zones[0]

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3" // ubuntu-20-04-lts-v20220822   
      type     = "network-hdd"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[0].id
    ipv6      = false
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

resource "yandex_compute_instance" "runner" {
  name     = "runner"
  hostname = "runner.nzakirov.ru"
  zone     = var.zones[2]

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3" // ubuntu-20-04-lts-v20220822   
      type     = "network-hdd"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[2].id
    ipv6      = false
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}


