output "instance_external_ip" {
  value      = yandex_compute_instance.test_vm.network_interface.0.nat_ip_address
  depends_on = [yandex_compute_instance.test_vm]
}
