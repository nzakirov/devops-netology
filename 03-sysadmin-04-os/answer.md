# 1.

```bash
vagrant@vagrant:~$ sudo -i
root@vagrant:~# cd /opt
root@vagrant:/opt# wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
root@vagrant:/opt# tar xvzf node_exporter-1.3.1.linux-amd64.tar.gz 
root@vagrant:/opt# mv  node_exporter-1.3.1.linux-amd64 node_exporter
```

```bash
root@vagrant:/opt# ls -lah node_exporter/
total 18M
drwxr-xr-x 2 root root 4.0K Jan 29 16:04 .
drwxr-xr-x 4 root root 4.0K Jan 29 16:03 ..
-rw-r--r-- 1 root root  12K Dec  5 11:15 LICENSE
-rwxr-xr-x 1 root root  18M Jan 29 08:52 node_exporter
-rw-r--r-- 1 root root  463 Dec  5 11:15 NOTICE
```

```bash
root@vagrant:/opt# vim /etc/systemd/system/node_exporter.service
```

```bash
root@vagrant:/opt# cat /etc/systemd/system/node_exporter.service 
[Unit]
Description=Node Exporter hardware- and kernel-related metrics
Documentation=https://github.com/prometheus/node_exporter
After=network.target

[Service]
User=root
EnvironmentFile=/etc/default/node_exporter
ExecStart=/opt/node_exporter/node_exporter $OPTIONS
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
```

```bash
root@vagrant:/opt# vim /etc/default/node_exporter 

root@vagrant:/opt# cat /etc/default/node_exporter 
OPTIONS=''
```

```bash
root@vagrant:~# systemctl enable node_exporter
root@vagrant:~# systemctl restart node_exporter
root@vagrant:~# journalctl -eu node_exporter
```

```bash
root@vagrant:~# reboot
```
 
Проверяем что сервис запускается после перезагрузки:

```root@vagrant:~# systemctl status node_exporter```

<img src="https://drive.google.com/uc?export=view&id=12e1Tgj_0OP9d9018WLm2lyoX9VfN_CpR" width="600px">


# 2.

CPU:

```bash
vagrant@vagrant:~$  curl -s localhost:9100/metrics 2>/dev/null | grep node_cpu_seconds|egrep 'idle|system|user'|grep -v ^#
node_cpu_seconds_total{cpu="0",mode="idle"} 13152.92
node_cpu_seconds_total{cpu="0",mode="system"} 32.45
node_cpu_seconds_total{cpu="0",mode="user"} 21.78
node_cpu_seconds_total{cpu="1",mode="idle"} 13152.57
node_cpu_seconds_total{cpu="1",mode="system"} 34.47
node_cpu_seconds_total{cpu="1",mode="user"} 17.18
```

Память:

```bash
vagrant@vagrant:~$ curl -s localhost:9100/metrics 2>/dev/null | grep node_memory|egrep 'MemAvail|MemFree'|grep -v ^#
node_memory_MemAvailable_bytes 1.782554624e+09
node_memory_MemFree_bytes 1.571426304e+09
```

Диск:

```bash
vagrant@vagrant:~$ curl -s localhost:9100/metrics 2>/dev/null | grep node_disk|grep 'dm-0'|egrep "io|read|write"|grep -v ^#
node_disk_io_now{device="dm-0"} 0
node_disk_io_time_seconds_total{device="dm-0"} 14.956
node_disk_io_time_weighted_seconds_total{device="dm-0"} 18.464
node_disk_read_bytes_total{device="dm-0"} 2.3986688e+08
node_disk_read_time_seconds_total{device="dm-0"} 14.712
node_disk_reads_completed_total{device="dm-0"} 8428
node_disk_reads_merged_total{device="dm-0"} 0
node_disk_write_time_seconds_total{device="dm-0"} 3.7520000000000002
node_disk_writes_completed_total{device="dm-0"} 2917
node_disk_writes_merged_total{device="dm-0"} 0
```

Сеть

```bash
vagrant@vagrant:~$ curl -s localhost:9100/metrics 2>/dev/null | grep node_network|grep eth0|egrep 'receive|transmit'|grep -v ^#
node_network_receive_bytes_total{device="eth0"} 456116
node_network_receive_compressed_total{device="eth0"} 0
node_network_receive_drop_total{device="eth0"} 0
node_network_receive_errs_total{device="eth0"} 0
node_network_receive_fifo_total{device="eth0"} 0
node_network_receive_frame_total{device="eth0"} 0
node_network_receive_multicast_total{device="eth0"} 0
node_network_receive_packets_total{device="eth0"} 5893
node_network_transmit_bytes_total{device="eth0"} 423723
node_network_transmit_carrier_total{device="eth0"} 0
node_network_transmit_colls_total{device="eth0"} 0
node_network_transmit_compressed_total{device="eth0"} 0
node_network_transmit_drop_total{device="eth0"} 0
node_network_transmit_errs_total{device="eth0"} 0
node_network_transmit_fifo_total{device="eth0"} 0
node_network_transmit_packets_total{device="eth0"} 3705
node_network_transmit_queue_length{device="eth0"} 1000
```
 

# 3.

<img src="https://drive.google.com/uc?export=view&id=18fhOzo-Brm_zN4Hx8i5qf6LVonIA6ZTX" width="600px">


# 4.

Да, можно. ОС осознает что запущена в виртуальной среде.

```bash
vagrant@vagrant:~$ dmesg|egrep -i 'kvm|hypervisor|virt'
[    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000002] kvm-clock: cpu 0, msr 72401001, primary cpu clock
[    0.000002] kvm-clock: using sched offset of 79049170971 cycles
[    0.000046] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.007505] CPU MTRRs all blank - virtualized system.
[    0.186706] Booting paravirtualized kernel on KVM
[    0.097148] kvm-clock: cpu 1, msr 72401041, secondary cpu clock
[    0.714424] clocksource: Switched to clocksource kvm-clock
[    6.079169] systemd[1]: Detected virtualization oracle.
```


# 5.

```bash
vagrant@vagrant:~$ sysctl fs.nr_open
fs.nr_open = 1048576
```

Переменная задает лимит по количеству открытых файловых дескрипторов для ядра.

Мягкий лимит:

```bash
vagrant@vagrant:/proc/sys/fs$ ulimit -Sn
1024
```


# 6.

<img src="https://drive.google.com/uc?export=view&id=1Q5-DitSSokp-lR8GqZO5tCs0anV9aS5h" width="600px">





