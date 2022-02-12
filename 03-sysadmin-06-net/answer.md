# 1.

```bash
HTTP/1.1 301 Moved Permanently
cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
```

Код перенаправления "301 Moved Permanently" протокола HTTP показывает, что запрошенный ресурс был окончательно перемещён в URL, указанный в заголовке location. Браузер в случае такого ответа перенаправляется на эту страницу, а поисковые системы обновляют свои ссылки на ресурс.

# 2.

Status Code: 307 Internal Redirect

Время загрузки страницы: 960мс

Второй запрос обрабатывался дольше всего: 393мс


<img src="https://drive.google.com/uc?export=view&id=1kajjtsXkkhXYPuvKzX6j_1JR-KkllM3j" width="600px">

# 3.

```bash
❯ curl ifconfig.me
83.69.106.161
```

# 4.

```❯ whois -h whois.ripe.net 83.69.106.161```

```bash

...

organisation:   ORG-TI6-RIPE
org-name:       OJSC "Vimpelcom"
org-type:       OTHER
address:        Tatintelcom Inc.
                Lavrentiev st. 3
                420126 Kazan/Tatarstan 420126
                Russian Federation
phone:          +7 843 56760 00
fax-no:         +7 843 5676002

...

route:          83.69.106.0/24
descr:          Broadband Beeline Static
origin:         as29125
```

# 5.

```bash
❯ traceroute -An 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  192.168.1.1 [*]  0.365 ms  0.321 ms  0.302 ms
 2  78.107.182.101 [AS8402]  0.862 ms  0.949 ms  0.930 ms
 3  78.107.182.36 [AS29125]  0.805 ms  0.999 ms  0.874 ms
 4  194.186.88.33 [AS3216/AS23649]  1.726 ms  1.708 ms  1.417 ms
 5  79.104.225.13 [AS3216]  19.890 ms  20.142 ms  20.124 ms
 6  72.14.213.116 [AS15169]  12.328 ms 81.211.29.103 [AS3216]  24.665 ms 72.14.213.116 [AS15169]  12.148 ms
 7  * * 108.170.250.66 [AS15169]  13.218 ms
 8  * * *
 9  216.239.57.222 [AS15169]  34.684 ms 72.14.235.69 [AS15169]  38.833 ms 209.85.254.6 [AS15169]  24.705 ms
10  172.253.51.237 [AS15169]  27.696 ms 172.253.51.223 [AS15169]  26.765 ms 142.250.56.215 [AS15169]  35.131 ms
11  * * *
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  8.8.8.8 [AS15169]  26.394 ms  32.362 ms *
```

# 6.




