# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).

<details><summary>></summary>

> Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием терраформа и aws. 
> 
> 1. Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя, а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано [здесь](https://www.terraform.io/docs/backends/types/s3.html).
> 1. Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше. 

</details>


Создаем s3 бакет при помощи утилиты ```s3cmd```:

```
❯ s3cmd mb s3://terraform-state-nz
Bucket 's3://terraform-state-nz/' created

❯ s3cmd ls
2022-07-23 17:16  s3://terraform-state-nz
```

Объявляем созданный бакет в terrafrom:

```terraform
 backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "terraform-state-nz"
    region = "ru-central1"
    key = "terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
  }
```

