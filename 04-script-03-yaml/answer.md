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

