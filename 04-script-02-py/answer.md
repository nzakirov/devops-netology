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


# 4.


