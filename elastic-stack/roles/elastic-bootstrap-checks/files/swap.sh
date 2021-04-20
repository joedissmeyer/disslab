#!/bin/sh
sysctl vm.swappiness
echo "vm.swappiness=1" | sudo tee /etc/sysctl.d/swap.conf
cat /etc/sysctl.d/swap.conf
sysctl -p /etc/sysctl.d/swap.conf
sysctl vm.swappiness