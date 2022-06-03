#!/usr/bin/env bash

# INSTALL AND CONFIGURE ANSIBLE SEMAPHORE ON FEDORA SERVER 36+

# Install and set up MariaDB
yum install -y mariadb-server
systemctl enable --now mariadb.service

# mysql_secure_installation --- This is an interactive setup procedure. Automate this later.
mysql_secure_installation

# Install Ansible
yum install -y ansible

# Install Git
yum install -y git

# Download the Ansible Semaphore RPM package
wget https://github.com/ansible-semaphore/semaphore/releases/download/v2.8.49/semaphore_2.8.49_linux_amd64.rpm

# Install
sudo yum install semaphore_2.8.49_linux_amd64.rpm
rm -rf semaphore_2.8.49_linux_amd64.rpm

# Set up systemd unit file -- it will be called `SEMAPHORE`
sudo cat > /etc/systemd/system/semaphore.service <<EOF
[Unit]
Description=Semaphore Ansible
Documentation=https://github.com/ansible-semaphore/semaphore
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/bin/semaphore -config /etc/semaphore/config.json
SyslogIdentifier=semaphore
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Run the semaphore setup -- follow prompts
semaphore setup

# Reload the service daemon and start it up
systemctl daemon-reload
systemctl start semaphore
