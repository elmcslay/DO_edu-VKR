terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "${file("/var/lib/jenkins/scrts/key.json")}"
  zone = "ru-central1-b"
  cloud_id = "b1g8au9em58afkdtkahm"
  folder_id = "b1go28jbjr6v23i268qj"
}


resource "yandex_compute_instance" "vm-1" {
  name = "build-vm"
  hostname = "build-vm"
  platform_id = "standard-v3"

 resources {
    cores = 2
    memory = 2
 }

  boot_disk {
    initialize_params {
      image_id = "fd8snjpoq85qqv0mk9gi"
      type = "network-ssd"
      size = 10
    }
  }

  network_interface {
    subnet_id = "e2l0aklkamuvt9s69baf"
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/var/lib/jenkins/.ssh/build_key.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }

  
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/var/lib/jenkins/.ssh/build_key")
    host = self.network_interface[0].nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt install python -y"
    ]
  }

  provisioner "local-exec" {
    command = "echo > /tmp/test1 && echo '[build]' > /tmp/test1 && echo ${self.network_interface[0].nat_ip_address} >> /tmp/test1"
  }
}
