variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDkMVn4NB1991Kv34Q1tJCdR2K/stQdWD4bi0ebIbdPF0TofpSOACs6yMTr6Dl5/40hUA2r7S/ae12PdxFixjNYenEnM/ZzLTSf0t/ZEQfq/+H+mMUPNj7X9rzkKmJGXh6RcxcM0p+yyCZY3GDwyaY1hRFCEQxrfZXKeij6jiVzDW2i7qLz16ilNjyQyX2vIi3d+Z5mqKgdoR2YVTlJ4f5nx1u++b3cCq8M8syn9Ss+XGDoj5tSt0oDtzo2YFaCyNXy6TLWEpDUHx1mJSwoUn3N8ZSJTO8+6gy6foNmnIWEsPH6gysAHMljV+VMg1pdm0/QEytRlkexz4G/ANtZqPJkklY9A5TGznZD2qslHKsgGatD67BRoaO86M1ziKFq/KCMH1fXO3pOy4IEAX4wuKLin7WQW2K5MHP4y3Vv6keBtafvCRCBKEAYTlAtTZ3WKqe0K3KRIOET9wrkVYmkZKVWpGgevUl5tIwlZZzUx7e6Fa+7BS76eB9FjCcpwzIC7Vc= josephdissmeyer@Josephs-MacBook-Pro.local"
}
variable "proxmox_host" {
  default = "proxmox"
}
variable "template_name" {
  default = "fedora-36-template"
}
variable "pm_api_token_id" {
  default = "terraform-user@pam!terraform_token"
  sensitive = true
}
variable "pm_api_token_secret" {
  default = "82d78f38-1aae-4429-8387-a14354fc5ddd"
  sensitive = true
}