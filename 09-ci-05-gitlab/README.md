# Домашнее задание к занятию "09.05 Gitlab"

## Подготовка к выполнению

>1. Необходимо [зарегистрироваться](https://about.gitlab.com/free-trial/)
>2. Создайте свой новый проект
>3. Создайте новый репозиторий в gitlab, наполните его [файлами](./repository)
>4. Проект должен быть публичным, остальные настройки по желанию

## Основная часть

### DevOps

>В репозитории содержится код проекта на python. Проект - RESTful API сервис. Ваша задача автоматизировать сборку образа с выполнением python-скрипта:
>1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated)
>2. Python версии не ниже 3.7
>3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`
>4. Создана директория `/python_api`
>5. Скрипт из репозитория размещён в /python_api
>6. Точка вызова: запуск скрипта
>7. Если сборка происходит на ветке `master`: Образ должен пушится в docker registry вашего gitlab `python-api:latest`, иначе этот шаг нужно пропустить

```
❯ docker pull registry.gitlab.com/nzakirov/netology-09-ci-05-gitlab:latest
latest: Pulling from nzakirov/netology-09-ci-05-gitlab
2d473b07cdd5: Already exists
2054e173a103: Pull complete
74e2eea5e4c7: Pull complete
0275163eb24f: Pull complete
8f8bc6b0bfc8: Pull complete
d6217f932e52: Pull complete
Digest: sha256:431f77f2d9e6b6d8250836aa7e5c06aa94819f620cb7b5cc000f5d0ac47a3ecc
Status: Downloaded newer image for registry.gitlab.com/nzakirov/netology-09-ci-05-gitlab:latest
registry.gitlab.com/nzakirov/netology-09-ci-05-gitlab:latest
```

```
❯ docker run -d --name 09-ci-05-gitlab -p 5290:5290 registry.gitlab.com/nzakirov/netology-09-ci-05-gitlab:latest
77031c86319863177e1de62f21006ffa7090db827d73d30730e8ae359e1ade83
```

```
❯ curl localhost:5290/get_info
{"version": 3, "method": "GET", "message": "Already started"}
```
### Product Owner

>Вашему проекту нужна бизнесовая доработка: необходимо поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:
>1. Какой метод необходимо исправить
>2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`
>3. Issue поставить label: feature

### Developer

>Вам пришел новый Issue на доработку, вам необходимо:
>1. Создать отдельную ветку, связанную с этим issue
>2. Внести изменения по тексту из задания
>3. Подготовить Merge Requst, влить необходимые изменения в `master`, проверить, что сборка прошла успешно


### Tester

>Разработчики выполнили новый Issue, необходимо проверить валидность изменений:
>1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность
>2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый

## Итог

>После успешного прохождения всех ролей - отправьте ссылку на ваш проект в гитлаб, как решение домашнего задания

## Необязательная часть

>Автомазируйте работу тестировщика, пусть у вас будет отдельный конвейер, который автоматически поднимает контейнер и выполняет проверку, например, при помощи curl. На основе вывода - будет приниматься решение об успешности прохождения тестирования

