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


