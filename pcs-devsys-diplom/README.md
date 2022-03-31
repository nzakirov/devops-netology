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


## Установка vaut

```
root@vagrant:/# curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
root@vagrant:/# apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
root@vagrant:/# apt update && apt install vault
```

<img src="https://drive.google.com/uc?export=view&id=1zQ9B5AM5Pk5YRn49CDtDC3-8skknOkM" width="600px">

