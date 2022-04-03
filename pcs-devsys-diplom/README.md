# 2.

## Установка, настройка ufw

```root@vagrant:/# apt install -y ufw```

```
root@vagrant:/# ufw status
Status: inactive
```

```
root@vagrant:/# ufw default deny incoming
Default incoming policy changed to 'deny'
(be sure to update your rules accordingly)
```

```
root@vagrant:/# ufw default allow outgoing
Default outgoing policy changed to 'allow'
(be sure to update your rules accordingly)
```

```
root@vagrant:/# ufw allow ssh
Rules updated
Rules updated (v6)
```

```
root@vagrant:/# ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
```

```
root@vagrant:/# ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere                  
22/tcp (v6)                ALLOW IN    Anywhere (v6)             
```

```
root@vagrant:/# ufw allow 443
Rule added
Rule added (v6)
```

```
root@vagrant:/# ufw allow from 127.0.0.1
Rule added
root@vagrant:/# ufw allow to 127.0.0.1
Rule added
root@vagrant:/# ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere                  
443                        ALLOW IN    Anywhere                  
Anywhere                   ALLOW IN    127.0.0.1                 
127.0.0.1                  ALLOW IN    Anywhere                  
22/tcp (v6)                ALLOW IN    Anywhere (v6)             
443 (v6)                   ALLOW IN    Anywhere (v6)             
```

# 3.

## Установка vaut

```
root@vagrant:/# curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
root@vagrant:/# apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
root@vagrant:/# apt update && apt install vault
```

<img src="https://drive.google.com/uc?export=view&id=1zQ9B5AM5Pk5YRn49CDtDC3-8skknOkMb" width="600px">


# 4.

Согласно задания запускаем vault server  в режиме dev:

```root@vagrant:/etc/vault.d# vault server -dev -dev-root-token-id root```

```
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.17.7
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.10.0
             Version Sha: 7738ec5d0d6f5bf94a809ee0f6ff0142cfa525a6

==> Vault server started! Log data will stream in below:
```

Добавляем необходимые переменные окружения:

```root@vagrant:~# export VAULT_ADDR=http://127.0.0.1:8200```

```root@vagrant:~# export VAULT_TOKEN=root```

Активируем инфраструктуру открытых ключей:

```
root@vagrant:~# vault secrets enable pki
Success! Enabled the pki secrets engine at: pki/
```

```
root@vagrant:~# vault secrets tune -max-lease-ttl=87600h pki
Success! Tuned the secrets engine at: pki/
```

Создаем собственный корневой сертификат (CA):

```root@vagrant:~# vault write -field=certificate pki/root/generate/internal common_name="zakirov.su" ttl=87600h > CA_cert.crt```

```
root@vagrant:~# vault write pki/config/urls issuing_certificates="$VAULT_ADDR/v1/pki/ca" crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
Success! Data written to: pki/config/urls
```

Создаем промежуточный сертификат:

```
root@vagrant:~# vault secrets enable -path=pki_int pki
Success! Enabled the pki secrets engine at: pki_int/
```

```
root@vagrant:~# vault secrets tune -max-lease-ttl=43800h pki_int
Success! Tuned the secrets engine at: pki_int/
```

```
root@vagrant:~# vault write -format=json pki_int/intermediate/generate/internal common_name="zakirov.su Intermediate Authority" | jq -r '.data.csr' > pki_intermediate.csr
```

```
root@vagrant:~# vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr format=pem_bundle ttl="43800h" | jq -r '.data.certificate' > intermediate.cert.pem
```

```
root@vagrant:~# vault write  pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
Success! Data written to: pki_int/intermediate/set-signed
```

Прописываем роли:

```
root@vagrant:~# vault write pki_int/roles/zakirov-dot-su allowed_domains="zakirov.su" allow_subdomains=true max_ttl="720h"
Success! Data written to: pki_int/roles/zakirov-dot-su
```

Запрашиваем сертификат для сайта на срок 30 дней:

```
root@vagrant:~# vault write -format=json pki_int/issue/zakirov-dot-su common_name="test1.zakirov.su" alt_names="test1.zakirov.su" ttl="720h" > test1.zakirov.su.crt
```

Парсим файл сертификата в требуемый формат:

```
root@vagrant:~# cat test1.zakirov.su.crt | jq -r .data.certificate > test1.zakirov.su.crt.pem
root@vagrant:~# cat test1.zakirov.su.crt | jq -r .data.issuing_ca >> test1.zakirov.su.crt.pem
root@vagrant:~# cat test1.zakirov.su.crt | jq -r .data.private_key > test1.zakirov.su.crt.key
```

# 5.

Копируем корневой сертификат с виртуальной на хостовую машину:

```root@vagrant:~#  scp -P 2200 CA_cert.crt znail@10.0.2.2:/home/znail/CA_cert.crt```

На хостовой машине:

```❯ sudo cp CA_cert.crt /usr/local/share/ca-certificates/```

```❯ sudo update-ca-certificates```

```
Updating certificates in /etc/ssl/certs...
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...

Adding debian:CA_cert.pem
done.
Updating Mono key store
Linux Cert Store Sync - version 4.6.2.0
Synchronize local certs with certs from local Linux trust store.
Copyright 2002, 2003 Motus Technologies. Copyright 2004-2008 Novell. BSD licensed.

I already trust 128, your new list has 129
Certificate added: CN=zakirov.su
1 new root certificates were added to your trust store.
Import process completed.
Done
done.
```

Добавляем корневой сертификат в браузер:

<img src="https://drive.google.com/uc?export=view&id=1XcjJmvX1S7g_x5k2mdVv-MltsuxUG35F" width="600px">

<img src="https://drive.google.com/uc?export=view&id=1UsY-9e1uaMf0-qmoY7FxPrEUKO3IannA" width="600px">

<img src="https://drive.google.com/uc?export=view&id=10_DbM1IuLUYuBRWhSCqqqnOio1kMQyU4" width="600px">


# 6.

Установка nginx:

```root@vagrant:~# apt update && apt upgrade```

```root@vagrant:~# apt install nginx```

<img src="https://drive.google.com/uc?export=view&id=1YMafGkoCLUTna_pDjL2jiXyphVidaHNe" width="600px">

# 7.

Настройка сайта https:

```vagrant@vagrant:~$ sudo mkdir -p /var/www/test1.zakirov.su/html```

```vagrant@vagrant:~$ sudo chown -R $USER:$USER /var/www/test1.zakirov.su/html```

```vagrant@vagrant:~$ sudo chmod -R 755 /var/www/test1.zakirov.su```

Создаем тестовую страничку:

```vagrant@vagrant:~$ vim /var/www/test1.zakirov.su/html/index.html```

```vagrant@vagrant:~$ cat /var/www/test1.zakirov.su/html/index.html```

```html
<html>
    <head>
        <title>Welcome to test1.zakirov.su!</title>
    </head>
    <body>
        <h1>Success!  The test1.zakirov.su server block is working!</h1>
    </body>
</html>
```

Создаем виртуальный хост сайта:

```vagrant@vagrant:~$ vim /etc/nginx/sites-available/test1.zakirov.su```

```
server {
        listen 80;
        listen [::]:80;
	server_name test1.zakirov.su;
	return 301 https://$host$request_uri;
}

server {
	listen 443 ssl;
	listen [::]:443 ssl;
	ssl_certificate /etc/nginx/certificate/test1.zakirov.su.crt.pem;
	ssl_certificate_key /etc/nginx/certificate/test1.zakirov.su.crt.key;
        root /var/www/test1.zakirov.su/html;
        index index.html index.htm index.nginx-debian.html;

        server_name test1.zakirov.su;

        location / {
                try_files $uri $uri/ =404;
        }
}
```

```vagrant@vagrant:~$ sudo ln -s /etc/nginx/sites-available/test1.zakirov.su /etc/nginx/sites-enabled/```

Проверяем конфиг nginx на ошибки:

```vagrant@vagrant:~$ sudo nginx -t```

```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

Применяем изменения:

```vagrant@vagrant:~$ sudo systemctl restart nginx```

# 8.

<img src="https://drive.google.com/uc?export=view&id=1UKtczCfpGMs-Vqpbkew5NIOQ777MJ-KE" width="600px">

<img src="https://drive.google.com/uc?export=view&id=1bwkGl3CkWN1aXs8I2NfrEk11fSJSGB5M" width="600px">

# 9.

Пишем скрипт для выпуска сертификата. Для универсальности в качестве параметров передается доменное имя и срок действия сертификата:

```bash
#!/bin/bash

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

dst_cert_path=/etc/nginx/certificate
domain=$1
ttl=$2
crt_file=${domain}.crt
key_file=${domain}.crt.key
pem_file=${domain}.crt.pem

vault write -format=json pki_int/issue/zakirov-dot-su \
	common_name="$domain" alt_names="$domain" \
       	ttl="$ttl" > $crt_file 

cat $crt_file | jq -r .data.certificate > ${dst_cert_path}/${pem_file} 
cat $crt_file | jq -r .data.issuing_ca >> ${dst_cert_path}/$pem_file 
cat $crt_file | jq -r .data.private_key > ${dst_cert_path}/$key_file

systemctl reload nginx
rm $crt_file
```

Результат работы скрипта - обновленный сертификат для нашего сайта (время жизни для теста 2 мин.):

<img src="https://drive.google.com/uc?export=view&id=1qpDtqbzEb_Hfc8RHQtzbLonJOD8u7RW_" width="600px">


# 10.

Помещаем скрипт в crontab для пользователя root (для теста время жизни сертификата 2 мин. запуск каждые 5 мин.):

```root@vagrant:~# crontab -e```

```*/5 * * * * /root/renewcert.sh test1.zakirov.su 2m``` 

Проверяем результат работы на сайте:

<img src="https://drive.google.com/uc?export=view&id=1_8hfqA2Fu4uLMFZk04Puhj4tK7zxG9FC" width="600px">

После очередного запуска скрипта через cron:

<img src="https://drive.google.com/uc?export=view&id=1lP9Aw9zHUSNCcjl_yNTTTo69_kc-wrRy" width="600px">
