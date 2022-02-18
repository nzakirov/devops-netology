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

 /etc/network/interfaces :

```bash
auto eth1.10
iface eth1.10 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    vlan-raw-device eth1
``` /etc/network/interfaces :

```bash
auto eth1.10
iface eth1.10 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    vlan-raw-device eth1
``` /etc/network/interfaces :

```bash
auto eth1.10
iface eth1.10 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    vlan-raw-device eth1
``` /etc/network/interfaces :

```bash
auto eth1.10
iface eth1.10 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    vlan-raw-device eth1
```

# 4.

Типы агрегации интерфейсов в Linux:

**Mode-0(balance-rr)** – Данный режим используется по умолчанию. Balance-rr обеспечивается балансировку нагрузки и отказоустойчивость. В данном режиме сетевые пакеты отправляются “по кругу”, от первого интерфейса к последнему. Если выходят из строя интерфейсы, пакеты отправляются на остальные оставшиеся. Дополнительной настройки коммутатора не требуется при нахождении портов в одном коммутаторе. При разностных коммутаторах требуется дополнительная настройка.

**Mode-1(active-backup)** – Один из интерфейсов работает в активном режиме, остальные в ожидающем. При обнаружении проблемы на активном интерфейсе производится переключение на ожидающий интерфейс. Не требуется поддержки от коммутатора.

**Mode-2(balance-xor)** – Передача пакетов распределяется по типу входящего и исходящего трафика по формуле ((MAC src) XOR (MAC dest)) % число интерфейсов. Режим дает балансировку нагрузки и отказоустойчивость. Не требуется дополнительной настройки коммутатора/коммутаторов.

**Mode-3(broadcast)** – Происходит передача во все объединенные интерфейсы, тем самым обеспечивая отказоустойчивость. Рекомендуется только для использования MULTICAST трафика.

**Mode-4(802.3ad)** – динамическое объединение одинаковых портов. В данном режиме можно значительно увеличить пропускную способность входящего так и исходящего трафика. Для данного режима необходима поддержка и настройка коммутатора/коммутаторов.

**Mode-5(balance-tlb)** – Адаптивная балансировки нагрузки трафика. Входящий трафик получается только активным интерфейсом, исходящий распределяется в зависимости от текущей загрузки канала каждого интерфейса. Не требуется специальной поддержки и настройки коммутатора/коммутаторов.

**Mode-6(balance-alb)** – Адаптивная балансировка нагрузки. Отличается более совершенным алгоритмом балансировки нагрузки чем Mode-5). Обеспечивается балансировку нагрузки как исходящего так и входящего трафика. Не требуется специальной поддержки и настройки коммутатора/коммутаторов.

Пример настройки:

```# apt-get install ifenslave```

```# ifdown eth0```

```# ifdown eth1```

```# /etc/init.d/networking stop```

Правим файл ```/etc/network/interfaces```:

```bash
auto bond0

iface bond0 inet static
    address 10.31.1.5
    netmask 255.255.255.0
    network 10.31.1.0
    gateway 10.31.1.254
    bond-slaves eth0 eth1
    bond-mode active-backup
    bond-miimon 100
    bond-downdelay 200
    bond-updelay 200
```


```# /etc/init.d/networking start```


