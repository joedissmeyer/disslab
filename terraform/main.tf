terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.10"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.0.200:8006/api2/json"
  pm_api_token_id = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure = true
}

# Provision the FREEIPA VM
resource "proxmox_vm_qemu" "ipaserver" {
  count = 1
  name = "freeipa"
  target_node = var.proxmox_host
  clone = var.template_name
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "50G"
    type = "scsi"
    storage = "Data"
    iothread = 1
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=192.168.0.201/24,gw=192.168.0.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

# Provision the Prometheus & Grafana VM
resource "proxmox_vm_qemu" "prometheus" {
  count = 1
  name = "prometheus"
  target_node = var.proxmox_host
  clone = var.template_name
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "50G"
    type = "scsi"
    storage = "Data"
    iothread = 1
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=192.168.0.202/24,gw=192.168.0.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

# Provision the Ansible AWX VM
resource "proxmox_vm_qemu" "ansible" {
  count = 1
  name = "ansible"
  target_node = var.proxmox_host
  clone = var.template_name
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "50G"
    type = "scsi"
    storage = "Data"
    iothread = 1
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=192.168.0.203/24,gw=192.168.0.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

# Provision kibana VM
resource "proxmox_vm_qemu" "elastic-kibana" {
  count = 1
  name = "kibana"
  target_node = var.proxmox_host
  clone = var.template_name
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "32G"
    type = "scsi"
    storage = "Data"
    iothread = 1
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=192.168.0.211/24,gw=192.168.0.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

# Provision logstash VMs
resource "proxmox_vm_qemu" "elastic-logstash" {
  count = 1
  name = "logstash"
  target_node = var.proxmox_host
  clone = var.template_name
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "32G"
    type = "scsi"
    storage = "Data"
    iothread = 1
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=192.168.0.212/24,gw=192.168.0.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

# Provision elastic-master VMs
resource "proxmox_vm_qemu" "elastic-master" {
  count = 3
  name = "elastic-master-${count.index + 1}"
  target_node = var.proxmox_host
  clone = var.template_name
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "32G"
    type = "scsi"
    storage = "Data"
    iothread = 1
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=192.168.0.22${count.index + 1}/24,gw=192.168.0.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

# Provision the elastic-data VMs
resource "proxmox_vm_qemu" "elastic-data" {
  count = 3
  name = "elastic-data-${count.index + 1}"
  target_node = var.proxmox_host
  clone = var.template_name
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "100G"
    type = "scsi"
    storage = "Data"
    iothread = 1
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=192.168.0.23${count.index + 1}/24,gw=192.168.0.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}