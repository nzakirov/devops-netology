### 4.

<img src="https://drive.google.com/uc?export=view&id=1M7DQCX12wJ6I8yR-_hqj-z2k0EUWcfIY" width="600px">

### 5.

<img src="https://drive.google.com/uc?export=view&id=1zpfTb1shzMAo-XPU3_2OiLs7_KqzgHC5" width="600px">



### 6.

<img src="https://drive.google.com/uc?export=view&id=1PU1wrQOPqT-5fYCnL_dvW1gufDcqF2dN" width="600px">

<img src="https://drive.google.com/uc?export=view&id=1-YYfyR-L_9K-714OS7IIFaBTJOWbjNIL" width="600px">



### 8.

 - HISTSIZE, 1178-я строка man
 - дирректива опции HISTCONTROL - использовать оба ограничения: не сохранять строки, совпадающие с последней выбранной командой (ignoredups)  и не сохранять строки начинающиеся с символа <пробел> (ignorespace).

### 9.

Фигурные скобки {} (braces) используются в след случаях, когда:

- необходимо расширить перечисление или список (строки 331, 1416, 1508 man)

- необходимо расширить переменную в строке

  например: 

  `foo=5`

  `foobar='blabla'`

  `echo "${foo}bar`" 

  будет выведено: 5bar

### 10.

`touch file{1..100000}`

будут созданы файлы file1, file2, ... file100000

300000 файлов создать не получиться, выведется ошибка:
 `-bash: /usr/bin/touch: Argument list too long`

она говрит о том что превышен лимит длины списка аргументов



### 11.

[[ ]]  - проверяет выражение или файл внутри скобок на истинность и возвращает код завершения в соответствии с результатами проверки (0 -- истина, 1 -- ложь).

[[ -d /tmp ]] - выполняет проверку существует ли каталог /tmp

в данном случае возвращает  Истина, т.к. каталог существует.



### 12.

`vagrant@vagrant:~$ mkdir /tmp/new_path_directory`

`vagrant@vagrant:~$ mkdir /tmp/new_path_directory/bash`

`vagrant@vagrant:~$ cp /bin/bash /tmp/new_path_directory/bash/`

`vagrant@vagrant:~$ export PATH=/tmp/new_path_directory/bash:$PATH`

`vagrant@vagrant:~$ type -a bash`



### 13.

 at - команды выполняются в указанное время
batch - команды выполняются когда средняя загрузка системы становится ниже значения 1.5













