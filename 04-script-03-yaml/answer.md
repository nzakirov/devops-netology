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

# 3.(*)

 ```python
#!/usr/bin/env python3

import sys
import os
import argparse
import json
import yaml
from json.decoder import JSONDecodeError

parser = argparse.ArgumentParser(description='Convert form json to yaml or yaml to  json.')
parser.add_argument("--file", required=True, type=str, help="Input file")

args = parser.parse_args()
input_file = args.file
file_ext = input_file.split('.')[-1]
file_name = '.'.join(input_file.split('.')[:-1])
if file_name == '':
    file_name = input_file

def exists(path):
    try:
        os.stat(path)
    except OSError:
        return False
    return True


def is_json(filename):
    with open(filename, "r") as f:
        try:
            content  = json.load(f)
            return [True, content]
        except JSONDecodeError as err:
            return [False, err]


def is_yaml(filename):
    with open(filename, "r") as f:
        try:
            content  = yaml.safe_load(f)
            return [True, content]
        except (yaml.parser.ParserError, yaml.scanner.ScannerError) as err:
            return [False, err]


if not exists(input_file):
    print('Error: File not found')
    sys.exit(1)

valid_json = is_json(input_file)
valid_yaml = is_yaml(input_file)

if valid_json[0]:
    with open(f"{file_name}.yaml", "w") as fo:
        yaml.dump(valid_json[1], fo)
elif valid_yaml[0]:
    with open(f"{file_name}.json", "w") as fo:
        json.dump(valid_yaml[1], fo)
else:
    print(valid_yaml[1])
```

<img src="https://drive.google.com/uc?export=view&id=1DtLViPFw01qgIHl-rGhQVS4T7CXhPz2c" width="600px">
