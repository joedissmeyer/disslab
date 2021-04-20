#!/bin/sh

# Provision script for Ubuntu 20.04

# Assume root
sudo su -

# Run system updates
apt-get update
apt-get upgrade

# Install whois -- required for encrypting password
apt install whois

# Create the 'ansible' user and password. Add to sudoers.
# CREATE THIS SAME USER ON EACH SERVER YOU INTEND ON MANAGING WITH ANSIBLE
useradd -m -s /bin/bash ansible
passwd ansible
echo  -e 'ansible\tALL=(ALL)\tNOPASSWD:\tALL' > /etc/sudoers.d/ansible
mkpasswd --method=SHA-512

# Here is a copy of the encrypted password for 'Genes1s05'
# $6$Lt/WRv0wa7o2.7$FS7w8Y4ug9cne0U8hjhdqxp65xqSH8.352D/4HeZ9353T/fBnojHDN9gVz1Vc9WRnuaBSK0NIakB66y/BBU/S/

# On the Ansible control server, assume the 'ansible' user and generate the SSH keys. Use default options.
su - ansible
ssh-keygen -t rsa

# On the Ansible control server, install Ansible and the sshpass app
apt install ansible sshpass -y

# Set up the inventory file
vi /home/ansible/hosts

```
[servers]
dns1 ansible_host=192.168.1.201
ansible ansible_host=192.168.1.202
```

# Set up the ansible.cfg file
vi /home/ansible/ansible.cfg
```
[defaults]
inventory = /home/ansible/hosts
host_key_checking = False
```
