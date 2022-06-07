# 1.

Используя docker поднимаем инстанс PostgreSQL (версию 13). Данные БД сохраняются в volume.

```yaml
version: "3.3"

volumes:
  dbdata: {}
  pgadmin: {}
  backup:
    driver: local
    name: pg_backup

networks:
  postgres:
    driver: bridge

services:
  postgres:
    image: postgres:13
    environment:
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "123"
      PGDATA: "/var/lib/postgresql/data/pgdata"
    volumes:
      - "dbdata:/var/lib/postgresql/data"
      - "backup:/backup"
    ports:
      - "5432:5432"
    networks: 
      - postgres

  pgadmin:
    container_name: pgadmin_container
    image: dpage/pgadmin4:6.9
    environment:
      PGADMIN_DEFAULT_EMAIL: "nzakirov@gmail.com"
      PGADMIN_DEFAULT_PASSWORD: "123"
      PGADMIN_CONFIG_SERVER_MODE: "False"
    volumes:
      - pgadmin:/var/lib/pgadmin
    ports:
      - "5050:80"
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 1G
    networks:
      - postgres

```

Управляющие команды для:

- вывода списка БД:
```
 \l[+]   [PATTERN]      list databases
```
- подключения к БД:
```
  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "postgres")
```
- вывода списка таблиц:
```
\dt[S+] [PATTERN]      list tables
```
- вывода описания содержимого таблиц:
```
\d[S+]                 list tables, views, and sequences
```
выхода из psql:
```
\q                     quit psql
```

# 2.


