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

https://drive.google.com/file/d/12e1Tgj_0OP9d9018WLm2lyoX9VfN_CpR/view?usp=sharing

<img src="https://drive.google.com/uc?export=view&id=12e1Tgj_0OP9d9018WLm2lyoX9VfN_CpR" width="600px">







