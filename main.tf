resource "yandex_compute_disk" "boot_disk" {
  name     = "boot-hdd-20"
  type     = "network-hdd"
  zone     = var.zone
  image_id = var.ubuntu_image_id
  size     = "20"
}

resource "yandex_vpc_address" "public_ip" {
  name = "public_ip"
  external_ipv4_address {
    zone_id = var.zone
  }
}

resource "yandex_vpc_security_group" "vm_group_sg" {
  network_id = var.default_network_id

  ingress {
    description    = "Allow all ssh connections"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "test_vm" {
  name        = "test-vm-1"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk.id
  }

  network_interface {
    index              = 1
    subnet_id          = var.default_central_a_subnet
    nat                = true
    nat_ip_address     = yandex_vpc_address.public_ip.external_ipv4_address[0].address
    security_group_ids = [yandex_vpc_security_group.vm_group_sg.id]
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${tls_private_key.ssh_key.public_key_openssh}"
  }

  depends_on = [local_file.private_key, yandex_compute_disk.boot_disk, yandex_vpc_address.public_ip, yandex_vpc_security_group.vm_group_sg]
}