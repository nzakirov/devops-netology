# 1.

```bash
route-views>show ip route 83.69.106.161
Routing entry for 83.69.106.0/24
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 4d19h ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 4d19h ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 6939
      MPLS label: none
route-views>
```

```bash
route-views>show bgp 83.69.106.161
BGP routing table entry for 83.69.106.0/24, version 307610074
Paths: (22 available, best #17, table default)
  Not advertised to any peer
  Refresh Epoch 1
  8283 3216 29125, (aggregated by 29125 217.30.250.130)
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin incomplete, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:4416 8283:1 8283:101 29125:1280 65000:52254
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001 
      path 7FE0E621A378 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:4416 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 29125:1280
      path 7FE0A35D7908 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 3216 29125, (aggregated by 29125 217.30.250.130)
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external
      path 7FE0859457B8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE0FC51A250 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1351 6939 3216 29125, (aggregated by 29125 217.30.250.130)
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE01D95F928 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 1103 3216 29125, (aggregated by 29125 217.30.250.130)
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin incomplete, localpref 100, valid, external
      Community: 3216:2001 3216:4416 29125:1280
      path 7FE025684778 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:4416 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 3549:2581 3549:30840 29125:1280
      path 7FE17AB239C8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  701 1273 3216 29125, (aggregated by 29125 217.30.250.130)
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin incomplete, localpref 100, valid, external
      path 7FE113617A18 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 14315 6453 6453 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external
      Community: 14315:5000 53767:5000
      path 7FE08DD4F598 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 3216 29125, (aggregated by 29125 217.30.250.130)
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:4416 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 29125:1280
      path 7FE03B922310 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  4901 6079 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE0FD638730 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 3257 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8070 3257:30515 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE0C6256758 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3303 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 3216:2001 3216:4416 3303:1004 3303:1006 3303:3052 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065 3356:10725 29125:1280
      path 7FE0A3061718 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external
      Community: 7018:5000 7018:37232
      path 7FE13DA0C390 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7660 2516 1273 3216 29125, (aggregated by 29125 217.30.250.130)
    203.181.248.168 from 203.181.248.168 (203.181.248.168)
      Origin incomplete, localpref 100, valid, external
      Community: 2516:1030 7660:9003
      path 7FE09FEFF758 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 3910 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE14EC2E2E0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 3216 29125, (aggregated by 29125 217.30.250.130)
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external, best
      path 7FE0DF939628 RPKI State not found
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  101 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external
      Community: 101:20100 101:20110 101:22100 3216:2001 3216:4416 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 29125:1280
      Extended Community: RT:101:22100
      path 7FE14F4179E0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 2
  2497 3216 29125, (aggregated by 29125 217.30.250.130)
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin incomplete, localpref 100, valid, external
      path 7FE0F2440858 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  49788 12552 3216 29125, (aggregated by 29125 217.30.250.130)
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin incomplete, localpref 100, valid, external
      Community: 12552:12000 12552:12100 12552:12101 12552:22000
      Extended Community: 0x43:100:1
      path 7FE12ABD7490 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1221 4637 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    203.62.252.83 from 203.62.252.83 (203.62.252.83)
      Origin IGP, localpref 100, valid, external
      path 7FE054586B88 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3257 3356 3216 29125, (aggregated by 29125 217.30.250.130)
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external
      Community: 3257:8794 3257:30043 3257:50001 3257:54900 3257:54901
      path 7FE1526433B8 RPKI State not found
      rx pathid: 0, tx pathid: 0
route-views>
```

# 2.

<img src="https://drive.google.com/uc?export=view&id=1lL18vPK3oDAle0acu-db0dfWCJvn7wLt" width="600px">

Для сохранения настроек после перезагрузки:

``root@vagrant:~# echo "dummy" >> /etc/modules```

```root@vagrant:~# echo "options dummy numdummies=2" > /etc/modprobe.d/dummy.conf```

```root@vagrant:/etc/netplan# vim 60-dummy.yaml```

```bash
network:
  version: 2
  renderer: networkd
  bridges:
    dummy0:
      dhcp4: no
      dhcp6: no
      accept-ra: no
      interfaces: [ ]
      addresses:
        - 10.4.4.4/32
```

Добавить статические  маршруты:

```root@vagrant:/etc/netplan# ip route add 10.2.1.0/27 via 192.168.1.1```

```root@vagrant:/etc/netplan# ip route add 10.3.2.0/27 via 192.168.1.1```


```root@vagrant:~# vim /etc/netplan/50-vagrant.yaml```

```bash
---
network:
  version: 2
  renderer: networkd
  ethernets:
    eth1:
      dhcp4: true
      routes:
      - to: 10.2.1.0/27
        via: 192.168.1.1
      - to: 10.3.2.0/27
        via: 192.168.1.1
```

```root@vagrant:~# ip route```

```bash
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100 
default via 192.168.1.1 dev eth1 proto dhcp src 192.168.1.25 metric 100 
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100 
10.2.1.0/27 via 192.168.1.1 dev eth1 proto static onlink 
10.3.2.0/27 via 192.168.1.1 dev eth1 proto static onlink 
192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.25 
192.168.1.1 dev eth1 proto dhcp scope link src 192.168.1.25 metric 100 
```

# 3.

Открытые TCP порты:

```root@vagrant:~# ss  -ntlp```

```bash
State                Recv-Q               Send-Q                             Local Address:Port                                Peer Address:Port               Process                                                  
LISTEN               0                    4096                                   127.0.0.1:8125                                     0.0.0.0:*                   users:(("netdata",pid=630,fd=26))                       
LISTEN               0                    4096                                     0.0.0.0:19999                                    0.0.0.0:*                   users:(("netdata",pid=630,fd=4))                        
LISTEN               0                    4096                               127.0.0.53%lo:53                                       0.0.0.0:*                   users:(("systemd-resolve",pid=608,fd=13))               
LISTEN               0                    128                                      0.0.0.0:22                                       0.0.0.0:*                   users:(("sshd",pid=671,fd=3))                           
LISTEN               0                    4096                                           *:9100                                           *:*                   users:(("node_exporter",pid=634,fd=3))                  
LISTEN               0                    128                                         [::]:22                                          [::]:*                   users:(("sshd",pid=671,fd=4))            
```

Приложения:

sshd: 22 порт

netdata: 19999 порт

node_exporter: 9100 порт


# 4.

```root@vagrant:~# ss  -nulp```

```bash
State                Recv-Q               Send-Q                                 Local Address:Port                             Peer Address:Port              Process                                                  
UNCONN               0                    0                                          127.0.0.1:8125                                  0.0.0.0:*                  users:(("netdata",pid=630,fd=25))                       
UNCONN               0                    0                                      127.0.0.53%lo:53                                    0.0.0.0:*                  users:(("systemd-resolve",pid=608,fd=12))               
UNCONN               0                    0                                  192.168.1.25%eth1:68                                    0.0.0.0:*                  users:(("systemd-network",pid=1876,fd=21))              
UNCONN               0                    0                                     10.0.2.15%eth0:68                                    0.0.0.0:*                  users:(("systemd-network",pid=1876,fd=23)) 
```

systemd-resolve: 53 порт

systemd-network: 68 порт


# 5.

<img src="https://drive.google.com/uc?export=view&id=17COdHn8AOFb54pS_CrGnZ-aAQcDRk8C1" width="600px">
