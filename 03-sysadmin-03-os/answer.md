# 1.

```bash
vagrant@vagrant:~$ strace /bin/bash -c 'cd /tmp' 2>&1|grep tmp
execve("/bin/bash", ["/bin/bash", "-c", "cd /tmp"], 0x7ffc5b351ab0 /* 23 vars */) = 0
stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
chdir("/tmp")      
```

# 2.

```bash
vagrant@vagrant:~$ strace -e read,openat file /dev/tty 2>&1|grep '\"\/' 
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libmagic.so.1", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/liblzma.so.5", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libbz2.so.1.0", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
openat(AT_FDCWD, "/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 3
vagrant@vagrant:~$ strace -e read,openat file /dev/sda 2>&1|grep '\"\/' 
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libmagic.so.1", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/liblzma.so.5", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libbz2.so.1.0", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
openat(AT_FDCWD, "/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 3
vagrant@vagrant:~$ strace -e read,openat file /bin/bash 2>&1|grep '\"\/' 
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libmagic.so.1", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/liblzma.so.5", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libbz2.so.1.0", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
openat(AT_FDCWD, "/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 3
openat(AT_FDCWD, "/bin/bash", O_RDONLY|O_NONBLOCK) = 3
```

База данных ```file``` находится в  ```/usr/share/misc/magic.mgc```

# 3.

<img src="https://drive.google.com/uc?export=view&id=1-txdx4BjMWK-aqTOWWcsCkhDqOKY6_oA" width="600px">

# 4.

Зомби-процессы занимают единственный ресурс в системе - это место в таблице процессов. При достижения лимита записей в таблице процессов может возникнуть ситуация когда невозможно будет создать процесс от имени пользователя. Также пользователь не сможет войти зайти на консоль как локальную, так и удаленную.

# 5. 

```bash
root@vagrant:~# opensnoop-bpfcc 
PID    COMM               FD ERR PATH
390    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.procs
390    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.threads
842    vminfo              5   0 /var/run/utmp
644    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
644    dbus-daemon        20   0 /usr/share/dbus-1/system-services
644    dbus-daemon        -1   2 /lib/dbus-1/system-services
644    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
649    irqbalance          6   0 /proc/interrupts
649    irqbalance          6   0 /proc/stat
649    irqbalance          6   0 /proc/irq/20/smp_affinity
649    irqbalance          6   0 /proc/irq/0/smp_affinity
649    irqbalance          6   0 /proc/irq/1/smp_affinity
649    irqbalance          6   0 /proc/irq/8/smp_affinity
649    irqbalance          6   0 /proc/irq/12/smp_affinity
649    irqbalance          6   0 /proc/irq/14/smp_affinity
649    irqbalance          6   0 /proc/irq/15/smp_affinity
842    vminfo              5   0 /var/run/utmp
644    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
644    dbus-daemon        20   0 /usr/share/dbus-1/system-services
644    dbus-daemon        -1   2 /lib/dbus-1/system-services
644    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
^Croot@vagrant:~# 
```

# 6.

Системный вызов ```uname``` .
``` Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.```

# 7.

При выполнении последовательности команд разделенных ```;``` следующая команда выполняется в любом случае вне зависисмости от того успешно или нет выполнилась предыдущая. При ```&&``` следующая команда выполняется только в том случае если предыдущая завершилась успешно.
```set -e``` устанавливает такое поведение bash, когда в случае если команда завершилась с ненулевым статусом (т.е. с ошибкой), таким образом смысла использовать && нет.

# 8. 

**-e** - Выйти немедленно если команда завершилась с ненулевым кодом возврата.
**-u** - Считать неинициализированные переменные при подстановке как ошибку.
**-x** - Выводить на экран команды и их аргументы как они закончат выполнение.
**-o** - Опция
Опция **pipefail** - возвращает ненулевое значение последней невыполненной команды, нулевое значение если все команды выполнились

# 9.

```bash
root@vagrant:~# ps -o 'stat' -a -x|tail -n+2|cut -c1|sort |uniq -c |sort -rn
     65 S
     45 I
      1 R
```

