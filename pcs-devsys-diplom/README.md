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

```root@vagrant:~# export VAULT_ADDR=http://127.0.0.1:8200```

```root@vagrant:~# export VAULT_TOKEN=root```

```
root@vagrant:~# vault secrets enable pki
Success! Enabled the pki secrets engine at: pki/
```

```
root@vagrant:~# vault secrets tune -max-lease-ttl=87600h pki
Success! Tuned the secrets engine at: pki/
```

```root@vagrant:~# vault write -field=certificate pki/root/generate/internal common_name="zakirov.su" ttl=87600h > CA_cert.crt```

```
root@vagrant:~# vault write pki/config/urls issuing_certificates="$VAULT_ADDR/v1/pki/ca" crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
Success! Data written to: pki/config/urls
```

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

```
root@vagrant:~# vault write pki_int/roles/zakirov-dot-su allowed_domains="zakirov.su" allow_subdomains=true max_ttl="720h"
Success! Data written to: pki_int/roles/zakirov-dot-su
```

```
root@vagrant:~# vault write -format=json pki_int/issue/zakirov-dot-su common_name="test1.zakirov.su" alt_names="test1.zakirov.su" ttl="720h" > test1.zakirov.su.crt
```

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



