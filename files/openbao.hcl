ui = true

storage "file" {
  path = "/opt/openbao/data"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

seal "pkcs11" {
  lib = "/usr/lib/softhsm/libsofthsm2.so"
  token_label = "OpenBao"
  pin = "4321"
  key_label = "bao-root-key-rsa"
  rsa_oaep_hash = "sha1"
}
