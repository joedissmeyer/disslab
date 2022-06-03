# Ansible Playbooks for the DISSLAB (Joey D's Test Homelab)

Included in this repo are the playbooks that I use to bootstrap and manage my homelab.

Documentation will be added as needed.

Be sure to read the description inside each playbook for details on how to run them.

## ansible-disslab-bootstrap.yml

Standardizes the DISSLAB Hosts.
It installs required packages, configures OS logging, sets up logrotate, and enables the message-of-the-day (motd) at SSH login.

## ansible-install-docker-ce.yml

Playbook to install Docker CE on Kubernetes hosts. 

## ansible-install-ipa-client.yml

Playbook to install FreeIPA Clients on DISSLAB hosts.

## ansible-install-k8s-step1-prereqs.yml

Prereqs for getting k8s hosts ready for installing Kubernetes.

## ansible-install-k8s-step2-masters.yml

Prereqs for getting k8s master nodes ready for installing Kubernetes.

## ansible-install-node-exporter.yml

Playbook to install Prometheus Node Exporter on DISSLAB hosts

## ansible-install-prometheus-server.yml

Playbook to install Prometheus Server
NOTE: This particular playbook sets up the prometheus server to listen on port 9091 instead of the default. This was done to accomodate for Fedora Server that runs Cockpit on port 9090.

## ansible-managed-node.yml

* This needs to be the first playbook run for a new lab build.
Ansible playbook for _initial setup_ for new hosts to become Ansible managed.

## ansible-system-updates.yml

Playbook to perform system updates and reboot if necessary.
