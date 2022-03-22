# 1.

```bash
❯ cat test.json|jq
parse error: Expected separator between values at line 7, column 13
❯ vim test.json
❯ cat test.json|jq
parse error: Unfinished string at EOF at line 13, column 0
❯ vim test.json
❯ cat test.json|jq
parse error: Invalid numeric literal at line 10, column 0
❯ vim test.json
❯ cat test.json|jq
```

```json
{
  "info": "Sample JSON output from our service\t",
  "elements": [
    {
      "name": "first",
      "type": "server",
      "ip": 7175
    },
    {
      "name": "second",
      "type": "proxy",
      "ip": "71.78.22.43"
    }
  ]
}
```

У одного из элементов массива некорректное значение свойства "ip" : 7175, у ip адреса другой формат 4 числа разделенных точкой.


# 2.

```python
#!/usr/bin/env python3

import socket
import os
import json
import yaml
import argparse

prev_hosts = []
curr_hosts = []

parser = argparse.ArgumentParser(description='A tutorial of hosts_ip!')
parser.add_argument("--ftype",
                    choices=["json", "yaml"],
                    default="json", type=str, help="File type")
args = parser.parse_args()
ft = args.ftype
hosts_file = "hosts_list"
if ft == "json":
    with open(f"{hosts_file}.json", "r") as fhosts:
        prev_hosts = json.load(fhosts)
else:
    with open(f"{hosts_file}.yaml", "r") as fhosts:
        prev_hosts = yaml.safe_load(fhosts)

# Сохранение в файл результатов предыдущей проверки
os.system(f"cp {hosts_file}.json {hosts_file}.json.`date +%Y%m%d%H%M%S`")
os.system(f"cp {hosts_file}.yaml {hosts_file}.yaml.`date +%Y%m%d%H%M%S`")

# Проверка текущего значения IP и соответствия последней проверке
for item in prev_hosts:
    curr_dict = {}
    for host in item:
        curr_ip = socket.gethostbyname(host)
        curr_dict[host] = curr_ip
        curr_hosts.append(curr_dict)
        if curr_ip == item[host]:
            print(f'{host} - {curr_ip}')
        else:
            print(f'[ERROR] {host} IP mismatch: {item[host]} {curr_ip}')

with open(f"{hosts_file}.json", "w") as fhosts:
    json.dump(curr_hosts, fhosts)

with open(f"{hosts_file}.yaml", "w") as fhosts:
    yaml.dump(curr_hosts, fhosts)
```

### Вывод скрипта при запуске при тестировании:
```
❯ ./hosts_ip.py
test1.zakirov.su - 10.10.0.1
test2.zakirov.su - 10.10.0.2
[ERROR] test3.zakirov.su IP mismatch: 10.10.0.3 10.10.0.5
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
[{"test1.zakirov.su": "10.10.0.1"}, {"test2.zakirov.su": "10.10.0.2"}, {"test3.zakirov.su": "10.10.0.5"}]
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
- test1.zakirov.su: 10.10.0.1
- test2.zakirov.su: 10.10.0.2
- test3.zakirov.su: 10.10.0.5
```
