#!/bin/bash

echo "# ===== set Yandex DNS ... "
> .curr_dns.txt
nmcli -g name,type connection  show  --active | awk -F: '/ethernet|wireless/ { print $1 }' | while read connection
do
  nmcli con mod "$connection" ipv6.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.ignore-auto-dns yes
  echo "${connection}:`nmcli -t -f IP4.DNS connection show ${connection} | cut -f2 -d':' | tr '\n' ' '`" >> .curr_dns.txt
  nmcli con mod "$connection" ipv4.dns "77.88.8.8 77.88.8.1"
  nmcli con down "$connection" && nmcli con up "$connection"
done
