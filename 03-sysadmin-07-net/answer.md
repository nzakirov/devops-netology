# 1.


```❯ ip -br -c link```

```bash
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
enp2s0           UP             00:1a:92:db:54:5e <BROADCAST,MULTICAST,UP,LOWER_UP> 
tun0             UNKNOWN        <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> 
```

В Linux команда ```ip```, в Windows команда ```ipconfig```

# 2.

LLDP – протокол для обмена информацией между соседними устройствами. Пакет lldpd.

# 3.

Технология VLAN.

Пример для Ubuntu:

Устанавливаем пакет vlan:

```sudo apt-get install vlan```

Загружаем модуль 8021q в ядро:

```sudo modprobe 8021q```

Создаем новые интерфейсы:

```sudo ip link add link eth1 name eth1.10 type vlan id 10```

Назначем адресс новому интерфейсу:

```sudo ip addr add 10.0.0.1/24 dev eth1.10```

Запускаем новый интерфейс:

```sudo ip link set up eth1.10```


Делаем настройку сохраняемой:

```sudo su -c 'echo "8021q" >> /etc/modules'```

Добавляем в  /etc/network/interfaces :

```bash
auto eth1.10
iface eth1.10 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    vlan-raw-device eth1
```



