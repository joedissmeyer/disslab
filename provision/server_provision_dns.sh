#!/bin/sh

# Provision script for Ubuntu 20.04

# Assume root
sudo su -

# Run system updates
apt-get update
apt-get upgrade


# Install bind
apt-get install bind9

# Allow Bind communication through the firewall
ufw allow Bind9

# Edit the bind server configuration file
vi /etc/bind/named.conf.options

# Add the settings to the file within the options block. Save and close.
```
listen-on {
192.168.1.0/24;
};
allow-query { any; };
forwarders {
8.8.8.8;
8.8.4.4;
};
```

# Edit the DNS zone file
vi /etc/bind/named.conf.local

# Append forwarding zone settings to the file
```
zone "disslab.local" {
    type master;
    file "/etc/bind/zones/db.disslab.local"; # zone file path
};
zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.168.1";  # 192.168.1.0/24 subnet
};
```

# Make the db.disslab.local zone file
mkdir /etc/bind/zones
vi /etc/bind/zones/db.disslab.local

# Populate file with forward zone data and nameserver info
```
$TTL    604800
@       IN      SOA     dns1.disslab.local. admin.disslab.local. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
; name servers - NS records
     IN      NS      dns1.disslab.local.

; name servers - A records
dns1.disslab.local.          IN      A       192.168.1.201

; A records
ansible.disslab.local.        IN      A      192.168.1.202
```

# Verify the server configuration using named-checkzone.
# No errors should appear which means it is good. The output should literally say "OK".
# If you get an error, double-check the config.
named-checkzone /etc/bind/named.conf.local /etc/bind/zones/db.disslab.local

# If verification passes, restart bind9 to make the settings stick.
systemctl restart bind9

# Test
nslookup dns1
nslookup www.google.com

# Add in the DNS settings to Ubuntu clients
sudo rm -f /etc/resolv.conf
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
ls -l /etc/resolv.conf
vi /etc/resolv.conf
