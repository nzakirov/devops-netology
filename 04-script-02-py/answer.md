# 1.

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | Произойдет ошибка выполнения  |
| Как получить для переменной `c` значение 12?  | `c = str(a) + b`  |
| Как получить для переменной `c` значение 3?  | `c = a + int(b)`  |


# 2.

```python
#!/usr/bin/env python3

import os

path = '~/courses/netology/devops/homeworks/devops-netology'
bash_command = [f'cd {path}', "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:      ', '')
        print(path + '/' + prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
❯ ./script-02-py-2.py
~/courses/netology/devops/homeworks/devops-netology/04-script-02-py/answer.md
~/courses/netology/devops/homeworks/devops-netology/04-script-02-py/test1
~/courses/netology/devops/homeworks/devops-netology/04-script-02-py/test2
```


# 3.

```python
#!/usr/bin/env python3

import os
import sys

path = sys.argv[1]
bash_command = [f'cd {path}', "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:      ', '')
        print(path + '/' + prepare_result)

```

### Вывод скрипта при запуске при тестировании:
```
❯ ./script-02-py-3.py ~/courses/netology/devops/homeworks/devops-netology
/home/znail/courses/netology/devops/homeworks/devops-netology/04-script-02-py/test1
/home/znail/courses/netology/devops/homeworks/devops-netology/04-script-02-py/test2
```

# 4.

Предполагаем, что существует файл 'hosts_list' в текущем каталоге, с содержимым последней проверки, в формате: <URL> <IP> (разделитель пробел). Также предполагаем, что формат файла не содержит ошибок форматирования и соответствует шаблону (функция проверки корректности файла вынесена за рамки данного скрипта и файл предварительно проверен на корректность)
При работе скрипта файл предыдущей проверки копируется в файл с добавлением временной метки в название файла.

```python
import socket
import os

prev_hosts = {}

# Чтение из файла в словарь результаты последней проверки. Ключ - URL, значение IP
file_hosts = open('hosts_list', 'r', encoding='utf-8')
for line in file_hosts:
    inputStr  = list(line.split(' '))
    url = inputStr[0]
    ip = inputStr[1].replace('\n', '')
    
    if url not in prev_hosts.keys():
        prev_hosts[url] = ip 
file_hosts.close()

# Сохранение в файл результатов предыдущей проверки
os.system('cp hosts_list hosts_list.`date +%Y%m%d%H%M%S`')

# Проверка текущего значения IP и соответствия последней проверке
file_hosts = open('hosts_list', 'w', encoding='utf-8')
for host in prev_hosts:
    curr_ip = socket.gethostbyname(host)
    if curr_ip == prev_hosts[host]:
        print(f'{host} - {curr_ip}')
    else:
        print(f'[ERROR] {host} IP mismatch: {prev_hosts[host]} {curr_ip}')
    file_hosts.write(host + ' ' + curr_ip + '\n')
file_hosts.close()
```

Вывод скрипта при запуске при тестировании:

```
test1.zakirov.su - 10.10.0.1
test2.zakirov.su - 10.10.0.2
[ERROR] test3.zakirov.su IP mismatch: 10.10.0.3 10.10.0.5
```

