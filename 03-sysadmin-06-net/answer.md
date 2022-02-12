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

```bash
                             My traceroute  [v0.94]
nail-PC (192.168.1.3) -> 8.8.8.8                        2022-02-12T21:39:55+0300
Ping Bit Pattern: 0
Pattern Range: 0(0x00)-255(0xff), <0 random.
 Host                                 Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. AS???    192.168.1.1               0.0%    45    0.3   0.3   0.3   0.4   0.0
 2. AS8402   78.107.182.101            0.0%    45    0.8   0.8   0.7   1.0   0.1
 3. AS8402   78.107.182.36             0.0%    45    0.8   1.2   0.7  16.7   2.4
 4. AS3216   79.104.3.53               0.0%    45    1.5   1.5   1.3   1.6   0.1
 5. AS???    79.104.235.213            0.0%    45   12.5  12.3  12.1  12.9   0.1
 6. AS15169  72.14.213.116             0.0%    45   12.5  13.8  11.9  76.5   9.6
 7. AS15169  108.170.250.113           8.9%    45   20.2  20.7  19.8  35.2   2.5
 8. AS15169  216.239.51.32            46.7%    45   34.3  34.9  34.2  39.0   1.2
 9. AS15169  108.170.232.251           0.0%    45   27.2  27.5  27.1  30.1   0.6
10. AS15169  142.250.209.171           0.0%    45   28.5  30.8  27.4  36.5   3.8
11. (waiting for reply)
12. (waiting for reply)
13. (waiting for reply)
14. (waiting for reply)
15. (waiting for reply)
16. (waiting for reply)
17. AS15169  8.8.8.8                  51.2%    44   26.3  26.4  26.2  26.5   0.1
```

На участке 8. AS15169  216.239.51.32  наибольшая задержка.

# 7.

```❯ dig dns.google```

DNS сервера:

```bash
;; AUTHORITY SECTION:
dns.google.		651	IN	NS	ns2.zdns.google.
dns.google.		651	IN	NS	ns3.zdns.google.
dns.google.		651	IN	NS	ns4.zdns.google.
dns.google.		651	IN	NS	ns1.zdns.google.

;; ADDITIONAL SECTION:
ns1.zdns.google.	313279	IN	A	216.239.32.114
ns2.zdns.google.	313279	IN	A	216.239.34.114
ns3.zdns.google.	313279	IN	A	216.239.36.114
ns4.zdns.google.	313279	IN	A	216.239.38.114
```

A записи:

```bash
dns.google.		841	IN	A	8.8.8.8
dns.google.		841	IN	A	8.8.4.4
```

# 8.

```❯ dig -x 216.239.32.114```

```bash
;; QUESTION SECTION:
;114.32.239.216.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
114.32.239.216.in-addr.arpa. 86264 IN	PTR	ns1.zdns.google.
```

```❯ dig -x 216.239.34.114```

```bash
;; QUESTION SECTION:
;114.34.239.216.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
114.34.239.216.in-addr.arpa. 86400 IN	PTR	ns2.zdns.google.
```

```❯ dig -x 216.239.36.114```

```bash
;; QUESTION SECTION:
;114.36.239.216.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
114.36.239.216.in-addr.arpa. 86400 IN	PTR	ns3.zdns.google.
```

```❯ dig -x 216.239.38.114```

```bash
;; QUESTION SECTION:
;114.38.239.216.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
114.38.239.216.in-addr.arpa. 86400 IN	PTR	ns4.zdns.google.
```
