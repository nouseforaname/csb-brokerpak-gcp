resource "random_string" "username" {
  length  = 16
  special = false
  number  = false
}

resource "random_password" "password" {
  length           = 64
  override_special = "~_-."
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
}

resource "postgresql_role" "new_user" {
  name     = random_string.username.result
  login    = true
  password = random_password.password.result
  roles = [
    var.admin_username
  ]
}

resource "local_file" "sslcert" {
  content         = var.sslcert
  filename        = "${path.module}/sslcert.pem"
  file_permission = "0600"
}

resource "local_sensitive_file" "sslkey" {
  content         = var.sslkey
  filename        = "${path.module}/sslkey.pem"
  file_permission = "0600"
}

resource "local_file" "sslrootcert" {
  content         = var.sslrootcert
  filename        = "${path.module}/sslrootcert.pem"
  file_permission = "0600"
}