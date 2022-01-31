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


