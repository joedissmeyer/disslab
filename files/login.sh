#!/bin/bash

if [ "$EUID" != 0 ]; then

  # Reset
NC="\e[0m"

HOSTNAME=$(hostname -s)
USER=$(logname)
SESSIONS=$(users | wc -w)
DOMAIN=$(dnsdomainname)
RELEASE=$(/bin/cat /etc/redhat-release)
IP=$(hostname -i)
MEM=$(free -g |grep Mem| awk '{print $2" GB"}')
CPU=$(/bin/lscpu |grep '^CPU(s)' |awk {'print $2'})
SELINUX=$(/usr/sbin/getenforce)

echo -e "-------------------------------------------------"
echo -e "Host Info"
echo -e "-------------------------------------------------"
echo -e "-------------------------------------------------"
echo -e "About:            ${HOSTNAME}${NC}"
echo -e "Logged in as:     ${USER}${NC}"
echo -e "-------------------------------------------------"
echo -e "Active Sessions:  ${SESSIONS}${NC}"
echo -e "Operating System: ${RELEASE}${NC}"
echo -e "FQDN:             ${HOSTNAME}.${DOMAIN}${NC}"
echo -e "IP:               ${IP}${NC}"
echo -e "Memory:           ${MEM}${NC}"
echo -e "Processers:       ${CPU}${NC}"
echo -e "SELinux:          ${SELINUX}${NC}"
echo -e "-------------------------------------------------"
fi