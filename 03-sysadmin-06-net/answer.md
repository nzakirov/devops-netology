# 1.

```bash
HTTP/1.1 301 Moved Permanently
cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
```

Код перенаправления "301 Moved Permanently" протокола HTTP показывает, что запрошенный ресурс был окончательно перемещён в URL, указанный в заголовке location. Браузер в случае такого ответа перенаправляется на эту страницу, а поисковые системы обновляют свои ссылки на ресурс.
