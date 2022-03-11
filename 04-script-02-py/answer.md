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
        print(os.getcwd() + '/' + prepare_result)
```
