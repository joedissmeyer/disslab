#!/bin/sh

# Provision script for Ubuntu 20.04

# Run system updates

sudo apt-get update
sudo apt-get upgrade

# Ensure the whois package is installed on the target host
apt install whois -y

# Fix the DNS lookup issue with Ubuntu

sudo rm -f /etc/resolv.conf
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
ls -l /etc/resolv.conf

# Create the ansible user and password

useradd -m -s /bin/bash ansible
echo -e "Genes1s05\nGenes1s05" | passwd ansible

# Add the Ansible user to the sudoers
echo  -e 'ansible\tALL=(ALL)\tNOPASSWD:\tALL' > /etc/sudoers.d/ansible

# Encrypt the Ansible user password
su - ansible
echo -e "Genes1s05" | mkpasswd --method=SHA-512

# Generate an SSH key for the Ansible user on the control server. Skip this for managed clients.
# On the control server you will assume the ansible user, then generate the SSH keys.
# ---
# $ su - ansible
# $ ssh-keygen -t rsa
# ---

# Now copy the Ansible user's SSH PUBLIC key to the Ansible user's _authorized_keys_ file on each host using ssh-host-id.
# This requires that the same ansible username and same password is on the target. Requires manual password entry.
# ---
# $ ssh-copy-id ansible@targethostname
# ---