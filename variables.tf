variable "zone" {
  description = "cloud zone"
  type        = string
}

variable "ubuntu_image_id" {
  description = "yandex ubuntu 24.04 LTS image id"
  type        = string
}

variable "default_central_a_subnet" {
  description = "default subnet in central_a zone"
  type        = string
}

variable "default_network_id" {
  description = "default yandex network id"
  type        = string
}

variable "ssh_user" {
  description = "user for ssh connections"
  type        = string
}