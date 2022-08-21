# Домашнее задание к занятию "08.03 Работа с Roles"

## Подготовка к выполнению
>1. Создайте два пустых публичных репозитория в любом своём проекте: elastic-role и kibana-role.
>2. Скачайте [role](./roles/) из репозитория с домашним заданием и перенесите его в свой репозиторий elastic-role.
>3. Скачайте дистрибутив [java](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) и положите его в директорию `playbook/files/`. 
>4. Установите molecule: `pip3 install molecule`
>5. Добавьте публичную часть своего ключа к своему профилю в github.

## Основная часть

>Наша основная цель - разбить наш playbook на отдельные roles. Задача: сделать roles для elastic, kibana и написать playbook для использования этих ролей. Ожидаемый результат: существуют два ваших репозитория с roles и один репозиторий с playbook.

>1. Создать в старой версии playbook файл `requirements.yml` и заполнить его следующим содержимым:
>   ```yaml
>   ---
>     - src: git@github.com:netology-code/mnt-homeworks-ansible.git
>       scm: git
>       version: "1.0.1"
>       name: java 
>   ```
>2. При помощи `ansible-galaxy` скачать себе эту роль. Запустите  `molecule test`, посмотрите на вывод команды.
```
❯ molecule test
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/home/znail/.cache/ansible-compat/38a096/modules:/home/znail/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/znail/.cache/ansible-compat/38a096/collections:/home/znail/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/znail/.cache/ansible-compat/38a096/roles:/home/znail/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /home/znail/.cache/ansible-compat/38a096/roles/my_namespace.java symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos8)
ok: [localhost] => (item=centos7)
ok: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

<. . .>

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

>3. Перейдите в каталог с ролью elastic-role и создайте сценарий тестирования по умолчаню при помощи `molecule init scenario --driver-name docker`.

```
❯ molecule init scenario --driver-name docker
INFO     Initializing new scenario default...
INFO     Initialized scenario in /home/znail/courses/netology/homeworks/local/08-ansible-03-role/elastic-role/molecule/default successfully.
```
>4. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
>5. Создайте новый каталог с ролью при помощи `molecule init role --driver-name docker kibana-role`. Можете использовать другой драйвер, который более удобен вам.
>6. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`. Проведите тестирование на разных дистрибитивах (centos:7, centos:8, ubuntu).
>7. Выложите все roles в репозитории. Проставьте тэги, используя семантическую нумерацию.
>8. Добавьте roles в `requirements.yml` в playbook.
>9. Переработайте playbook на использование roles.
>10. Выложите playbook в репозиторий.
>11. В ответ приведите ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.

## Необязательная часть

>1. Проделайте схожие манипуляции для создания роли logstash.
>2. Создайте дополнительный набор tasks, который позволяет обновлять стек ELK.
>3. В ролях добавьте тестирование в раздел `verify.yml`. Данный раздел должен проверять, что elastic запущен и возвращает успешный статус по API, web-интерфейс kibana отвечает без кодов ошибки, logstash через команду `logstash -e 'input { stdin { } } output { stdout {} }'`.
>4. Убедитесь в работоспособности своего стека. Возможно, потребуется тестировать все роли одновременно.
>5. Выложите свои roles в репозитории. В ответ приведите ссылки.
