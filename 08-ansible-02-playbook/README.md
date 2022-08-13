# Домашнее задание к занятию "08.02 Работа с Playbook"

## Подготовка к выполнению
>1. Создайте свой собственный (или используйте старый) публичный репозиторий на github с произвольным именем.
>2. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
>3. Подготовьте хосты в соотвтествии с группами из предподготовленного playbook. 

`docker-compose.yml`
```yaml
version: '3'
services:
  elastic:
    image: pycontribs/ubuntu
    container_name: elastic
    restart: unless-stopped
    entrypoint: "sleep infinity"

  kibana:
    image: pycontribs/ubuntu
    container_name: kibana
    restart: unless-stopped
    entrypoint: "sleep infinity"
```

>4. Скачайте дистрибутив [java](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) и положите его в директорию `playbook/files/`. 

## Основная часть
>1. Приготовьте свой собственный inventory файл `prod.yml`.
`❯ cat inventory/prod.yml`
```yaml
---
elasticsearch:
  hosts:
    elastic:
      ansible_connection: docker
kibana:
  hosts:
    kibana:
      ansible_connection: docker
```

>2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает kibana.
>3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
>4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, сгенерировать конфигурацию с параметрами.
```yaml
---
- name: Install Java
  hosts: all
  tasks:
    - name: Set facts for Java 11 vars
      set_fact:
        java_home: "/opt/jdk/{{ java_jdk_version }}"
      tags: java
    - name: Upload .tar.gz file containing binaries from local storage
      copy:
        src: "{{ java_oracle_jdk_package }}"
        dest: "/tmp/jdk-{{ java_jdk_version }}.tar.gz"
      register: download_java_binaries
      until: download_java_binaries is succeeded
      tags: java
    - name: Ensure installation dir exists
      become: true
      file:
        state: directory
        path: "{{ java_home }}"
      tags: java
    - name: Extract java in the installation directory
      become: true
      unarchive:
        copy: false
        src: "/tmp/jdk-{{ java_jdk_version }}.tar.gz"
        dest: "{{ java_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ java_home }}/bin/java"
      tags:
        - java
    - name: Export environment variables
      become: true
      template:
        src: jdk.sh.j2
        dest: /etc/profile.d/jdk.sh
      tags: java
- name: Install Elasticsearch
  hosts: elasticsearch
  tasks:
    - name: Upload .tar.gz Elasticsearch containing binaries from local storage
      copy:
        src: "{{ elastic_package }}"
        dest: "/tmp/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
      register: download_elastic_binaries
      until: download_elastic_binaries is succeeded
      tags: elastic

    - name: Create directrory for Elasticsearch
      file:
        state: directory
        path: "{{ elastic_home }}"
      tags: elastic
    - name: Extract Elasticsearch in the installation directory
      become: true
      unarchive:
        copy: false
        src: "/tmp/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
        dest: "{{ elastic_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ elastic_home }}/bin/elasticsearch"
      tags:
        - elastic
    - name: Set environment Elastic
      become: true
      template:
        src: templates/elk.sh.j2
        dest: /etc/profile.d/elk.sh
      tags: elastic

- name: Install Kibana
  hosts: kibana
  tasks:
    - name: Upload .tar.gz Kibana containing binaries from local storage
      copy:
        src: "{{ kibana_package }}"
        dest: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
      register: download_kibana_binaries
      until: download_kibana_binaries is succeeded
      tags: kibana

    - name: Create directrory for Kibana
      file:
        state: directory
        path: "{{ kibana_home }}"
      tags: kibana
    - name: Extract Kibana in the installation directory
      become: true
      unarchive:
        copy: false
        src: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "{{ kibana_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ kibana_home }}/bin/kibana"
      tags:
        - kibana
    - name: Set environment Kibana
      become: true
      template:
        src: templates/kib.sh.j2
        dest: /etc/profile.d/kib.sh
```
>5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
>6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
❯ ansible-playbook -i ./inventory/prod.yml site.yml --check
[WARNING]: Found both group and host with same name: kibana

PLAY [Install Java] *************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Set facts for Java 11 vars] ***********************************************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Upload .tar.gz file containing binaries from local storage] ***************************************************************************************
changed: [elastic]
changed: [kibana]

TASK [Ensure installation dir exists] *******************************************************************************************************************
changed: [elastic]
changed: [kibana]

TASK [Extract java in the installation directory] *******************************************************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: NoneType: None
fatal: [kibana]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.11' must be an existing dir"}
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: NoneType: None
fatal: [elastic]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.11' must be an existing dir"}

PLAY RECAP **********************************************************************************************************************************************
elastic                    : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
kibana                     : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
```
>7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

```
❯ ansible-playbook -i ./inventory/prod.yml site.yml --diff
[WARNING]: Found both group and host with same name: kibana

PLAY [Install Java] *************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************
ok: [kibana]
ok: [elastic]

TASK [Set facts for Java 11 vars] ***********************************************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Upload .tar.gz file containing binaries from local storage] ***************************************************************************************
diff skipped: source file size is greater than 104448
changed: [elastic]
diff skipped: source file size is greater than 104448
changed: [kibana]

TASK [Ensure installation dir exists] *******************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/jdk/11.0.11",
-    "state": "absent"
+    "state": "directory"
 }

changed: [kibana]
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/jdk/11.0.11",
-    "state": "absent"
+    "state": "directory"
 }

changed: [elastic]

TASK [Extract java in the installation directory] *******************************************************************************************************
changed: [kibana]
changed: [elastic]

TASK [Export environment variables] *********************************************************************************************************************
--- before
+++ after: /home/znail/.ansible/tmp/ansible-local-34700z25ww2h0/tmpktm3e3xi/jdk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export JAVA_HOME=/opt/jdk/11.0.11
+export PATH=$PATH:$JAVA_HOME/bin
\ No newline at end of file

changed: [elastic]
--- before
+++ after: /home/znail/.ansible/tmp/ansible-local-34700z25ww2h0/tmpxfiiy4md/jdk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export JAVA_HOME=/opt/jdk/11.0.11
+export PATH=$PATH:$JAVA_HOME/bin
\ No newline at end of file

changed: [kibana]

PLAY [Install Elasticsearch] ****************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************
ok: [elastic]

TASK [Upload .tar.gz Elasticsearch containing binaries from local storage] ******************************************************************************
diff skipped: source file size is greater than 104448
changed: [elastic]

TASK [Create directrory for Elasticsearch] **************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/elastic/7.10.1",
-    "state": "absent"
+    "state": "directory"
 }

changed: [elastic]

TASK [Extract Elasticsearch in the installation directory] **********************************************************************************************
changed: [elastic]

TASK [Set environment Elastic] **************************************************************************************************************************
--- before
+++ after: /home/znail/.ansible/tmp/ansible-local-34700z25ww2h0/tmpdymtkfki/elk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export ES_HOME=/opt/elastic/7.10.1
+export PATH=$PATH:$ES_HOME/bin
\ No newline at end of file

changed: [elastic]

PLAY [Install Kibana] ***********************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************
ok: [kibana]

TASK [Upload .tar.gz Kibana containing binaries from local storage] *************************************************************************************
diff skipped: source file size is greater than 104448
changed: [kibana]

TASK [Create directrory for Kibana] *********************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/kibana/7.10.1",
-    "state": "absent"
+    "state": "directory"
 }

changed: [kibana]

TASK [Extract Kibana in the installation directory] *****************************************************************************************************
changed: [kibana]

TASK [Set environment Kibana] ***************************************************************************************************************************
--- before
+++ after: /home/znail/.ansible/tmp/ansible-local-34700z25ww2h0/tmpaut0nerr/kib.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export KB_HOME=/opt/kibana/7.10.1
+export PATH=$PATH:$KB_HOME/bin

changed: [kibana]

PLAY RECAP **********************************************************************************************************************************************
elastic                    : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
kibana                     : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

>8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

```
❯ ansible-playbook -i ./inventory/prod.yml site.yml --diff
[WARNING]: Found both group and host with same name: kibana

PLAY [Install Java] *************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************
ok: [kibana]
ok: [elastic]

TASK [Set facts for Java 11 vars] ***********************************************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Upload .tar.gz file containing binaries from local storage] ***************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Ensure installation dir exists] *******************************************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Extract java in the installation directory] *******************************************************************************************************
skipping: [elastic]
skipping: [kibana]

TASK [Export environment variables] *********************************************************************************************************************
ok: [elastic]
ok: [kibana]

PLAY [Install Elasticsearch] ****************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************
ok: [elastic]

TASK [Upload .tar.gz Elasticsearch containing binaries from local storage] ******************************************************************************
ok: [elastic]

TASK [Create directrory for Elasticsearch] **************************************************************************************************************
ok: [elastic]

TASK [Extract Elasticsearch in the installation directory] **********************************************************************************************
skipping: [elastic]

TASK [Set environment Elastic] **************************************************************************************************************************
ok: [elastic]

PLAY [Install Kibana] ***********************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************
ok: [kibana]

TASK [Upload .tar.gz Kibana containing binaries from local storage] *************************************************************************************
ok: [kibana]

TASK [Create directrory for Kibana] *********************************************************************************************************************
ok: [kibana]

TASK [Extract Kibana in the installation directory] *****************************************************************************************************
skipping: [kibana]

TASK [Set environment Kibana] ***************************************************************************************************************************
ok: [kibana]

PLAY RECAP **********************************************************************************************************************************************
elastic                    : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
kibana                     : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```

>9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
>10. Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.
>
## Необязательная часть

>1. Приготовьте дополнительный хост для установки logstash.
>2. Пропишите данный хост в `prod.yml` в новую группу `logstash`.
>3. Дополните playbook ещё одним play, который будет исполнять установку logstash только на выделенный для него хост.
>4. Все переменные для нового play определите в отдельный файл `group_vars/logstash/vars.yml`.
>5. Logstash конфиг должен конфигурироваться в части ссылки на elasticsearch (можно взять, например его IP из facts или определить через vars).
>6. Дополните README.md, протестируйте playbook, выложите новую версию в github. В ответ предоставьте ссылку на репозиторий.
