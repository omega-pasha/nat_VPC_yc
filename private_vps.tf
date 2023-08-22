resource "yandex_compute_instance" "private-instance" {
  count = 1
  name  = "private-${count.index}"
  zone  = "ru-central1-a"
  allow_stopping_for_update = true
  platform_id = "standard-v2"
  hostname = "private-${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oshj0osht8svg6rfs"
      type     = "network-hdd"
      size     = "30"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private-subnet-a.id
    nat       = false
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

  scheduling_policy {
    preemptible = true
  }
}
