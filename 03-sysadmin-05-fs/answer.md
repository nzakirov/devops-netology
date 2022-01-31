# 1.


# 2.

Нет не могут, т.к. права доступа к объекту ФС хранятся в битовом поле индексного дескриптора (inode), а файлы являющиеся жесткой ссылкой на один объект имеют единый inode.


# 3.

<img src="https://drive.google.com/uc?export=view&id=1HtY-VB5Bh8av5FlGo1t2kP6EXZC_GvRV" width="600px">

# 4.

<img src="https://drive.google.com/uc?export=view&id=1DSkqK2bqDUUonmz9zAMVqaB0bjBUaX5p" width="600px">

# 5.

```bash
vagrant@vagrant:~$ sudo -i
root@vagrant:~# sfdisk -d /dev/sdb | sfdisk /dev/sdc
```

<img src="https://drive.google.com/uc?export=view&id=1U6u0JkeZ7SZkKNxYKFKzjoYw1dglMCo2" width="600px">

# 6.

Занулить суберблоки на диске:

```bash
root@vagrant:~# mdadm --zero-superblock --force /dev/sdb1 /dev/sdc1
mdadm: Unrecognised md component device - /dev/sdb1
mdadm: Unrecognised md component device - /dev/sdc1
```

Удалить старые метаданные и подпись на дисках:

```bash
root@vagrant:~# wipefs --al --force /dev/sdb1 /dev/sdc1
```

Создание рейда 1:

```root@vagrant:~# mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sdb1 /dev/sdc1```

Результат:

<img src="https://drive.google.com/uc?export=view&id=1cEboNSdzzyLMbpDZBrtNhlIBIzPMqygY" width="600px">


# 7.

Занулить суберблоки на диске:

```bash
root@vagrant:~# mdadm --zero-superblock --force /dev/sdb2 /dev/sdc2
mdadm: Unrecognised md component device - /dev/sdb2
mdadm: Unrecognised md component device - /dev/sdc2
```

Удалить старые метаданные и подпись на дисках:

```bash
root@vagrant:~# wipefs --al --force /dev/sdb2 /dev/sdc2
```

Создание рейда 0: 

```root@vagrant:~# mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sdb2 /dev/sdc2```

Результат:

<img src="https://drive.google.com/uc?export=view&id=10kskUcg9UmfKPD5d7lEduLwHq9QKCX2k" width="600px">

# 8.

```bash
root@vagrant:~# pvcreate /dev/md0 /dev/md1
  Physical volume "/dev/md0" successfully created.
  Physical volume "/dev/md1" successfully created.
```

Результат:

<img src="https://drive.google.com/uc?export=view&id=14mhWtBIWdRjJOjy1vt-0P_pOPK0UlXmH" width="600px">

# 9. 

```bash
root@vagrant:~# vgcreate vg01 /dev/md0 /dev/md1
  Volume group "vg01" successfully created
```

Результат:

```root@vagrant:~# vgdisplay```

<img src="https://drive.google.com/uc?export=view&id=1I6nqkG8k-gkAzOtyIuTRabe4hpP2zbJy" width="600px">

# 10.

```bash
root@vagrant:~# lvcreate -L 100M vg01 /dev/md1
  Logical volume "lvol0" created.
```

Результат:

<img src="https://drive.google.com/uc?export=view&id=1uBad4dYJaVSNcD6vq0q-B7CLdbiSW0zI" width="600px">

# 11.

```bash
root@vagrant:~# mkfs.ext4 /dev/vg01/lvol0 
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```

# 12.

```root@vagrant:~# cd /tmp```

```root@vagrant:/tmp# mkdir new```

```root@vagrant:/tmp# mount /dev/vg01/lvol0 /tmp/new```

Результат:

<img src="https://drive.google.com/uc?export=view&id=1nA2js0BRDjp24CTd_KD2IatlL-onouo9" width="600px">

# 13.

```bash
root@vagrant:/tmp# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2022-01-31 21:26:08--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22055889 (21M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz          100%[=====================================>]  21.03M  4.73MB/s    in 5.7s    

2022-01-31 21:26:13 (3.69 MB/s) - ‘/tmp/new/test.gz’ saved [22055889/22055889]

```

#  14.

<img src="https://drive.google.com/uc?export=view&id=17loCjO0Z9OjL2u6YOhCHgneTHh_fGvqG" width="600px">

# 15. 

```bash
root@vagrant:/tmp/new# gzip -t /tmp/new/test.gz 
root@vagrant:/tmp/new# echo $?
0
```

# 16.

```bash
root@vagrant:/tmp/new# pvmove /dev/md1
  /dev/md1: Moved: 12.00%
  /dev/md1: Moved: 100.00%
```

Результат:

<img src="https://drive.google.com/uc?export=view&id=1mJe05UTHuY244hPxem_aGo8CdIgGVpSk" width="600px">

# 17.

```bash
root@vagrant:/tmp/new# mdadm --fail /dev/md0 /dev/sdc1```
mdadm: set /dev/sdc1 faulty in /dev/md0
```

```bash
root@vagrant:/tmp/new# mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Mon Jan 31 16:51:20 2022
        Raid Level : raid1
        Array Size : 2094080 (2045.00 MiB 2144.34 MB)
     Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Mon Jan 31 21:54:13 2022
             State : clean, degraded 
    Active Devices : 1
   Working Devices : 1
    Failed Devices : 1
     Spare Devices : 0

Consistency Policy : resync

              Name : vagrant:0  (local to host vagrant)
              UUID : bd82f4e9:df10b61c:66f130be:c4bb75e4
            Events : 19

    Number   Major   Minor   RaidDevice State
       0       8       17        0      active sync   /dev/sdb1
       -       0        0        1      removed

       1       8       33        -      faulty   /dev/sdc1
```

# 18.

```bash
root@vagrant:/tmp/new# dmesg|grep 'md0'
[ 4573.598695] md/raid1:md0: not clean -- starting background reconstruction
[ 4573.598698] md/raid1:md0: active with 2 out of 2 mirrors
[ 4573.598719] md0: detected capacity change from 0 to 2144337920
[ 4573.603664] md: resync of RAID array md0
[ 4584.295085] md: md0: resync done.
[22746.276896] md/raid1:md0: Disk failure on sdc1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
root@vagrant:/tmp/new# 
```

# 19.

```bash
root@vagrant:/tmp/new# gzip -t /tmp/new/test.gz
root@vagrant:/tmp/new# echo $?
0
```

# 20.



