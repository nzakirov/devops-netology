#!/bin/bash

echo "# ===== remove Yandex DNS ... "
#nmcli -g name,type connection  show  --active | awk -F: '/ethernet|wireless/ { print $1 }' | while read connection
#do
#  nmcli con mod "$connection" ipv6.ignore-auto-dns yes
#  nmcli con mod "$connection" ipv4.ignore-auto-dns yes
#  nmcli con mod "$connection" ipv4.dns "192.168.1.1 8.8.8.8"
#  nmcli con down "$connection" && nmcli con up "$connection"
#done
cat .curr_dns.txt | while read str
do
  connection=`echo $str | cut -f1 -d':'`
  dnss=`echo $str | cut -f2 -d':'`
  nmcli con mod "$connection" ipv6.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.dns "$dnss"
  nmcli con down "$connection" && nmcli con up "$connection"
done
