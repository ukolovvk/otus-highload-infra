resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "private_key"
  file_permission = "0600"
  depends_on      = [tls_private_key.ssh_key]
}