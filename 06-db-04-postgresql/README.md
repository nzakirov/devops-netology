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

Используя ```psql``` создаем БД ```test_database```.
```sql
CREATE DATABASE test_database;
```

Восстанавливаем бэкап БД в ```test_database```:

```psql -U postgres -d test_database -f /backup/test_dump.sql```


```sql
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner   
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# \dS orders
                                   Table "public.orders"
 Column |         Type          | Collation | Nullable |              Default               
--------+-----------------------+-----------+----------+------------------------------------
 id     | integer               |           | not null | nextval('orders_id_seq'::regclass)
 title  | character varying(80) |           | not null | 
 price  | integer               |           |          | 0
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)

test_database=# SELECT * FROM orders;
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  2 | My little database   |   500
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  6 | WAL never lies       |   900
  7 | Me and my bash-pet   |   499
  8 | Dbiezdmin            |   501
(8 rows)
```

```sql
test_database=# ANALYZE orders;
ANALYZE
```

```sql
test_database=# SELECT MAX(avg_width) FROM pg_stats WHERE tablename = 'orders';
 max 
-----
  16
(1 row)
```

# 3.

Решать поставленную задачу разбиения разросшейся таблицы будем через партиционирование. Путем создания двух новых таблиц: ```orders_1``` и ```orders_2```.

```sql
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner   
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# ALTER TABLE orders RENAME TO orders_old;
ALTER TABLE
test_database=# \dt
           List of relations
 Schema |    Name    | Type  |  Owner   
--------+------------+-------+----------
 public | orders_old | table | postgres
(1 row)
```

```sql
test_database=# CREATE TABLE orders (id serial, title varchar(80), price integer) PARTITION BY RANGE(price);
CREATE TABLE

test_database=# CREATE TABLE orders_1 PARTITION OF  orders FOR VALUES FROM (0) TO (500);
CREATE TABLE

test_database=# CREATE TABLE orders_2 PARTITION OF  orders FOR VALUES FROM (500) TO (1000);
CREATE TABLE

test_database=# \dt
                 List of relations
 Schema |    Name    |       Type        |  Owner   
--------+------------+-------------------+----------
 public | orders     | partitioned table | postgres
 public | orders_1   | table             | postgres
 public | orders_2   | table             | postgres
 public | orders_old | table             | postgres
(4 rows)

test_database=# INSERT  INTO orders (id, title, price) SELECT * FROM  orders_old;
INSERT 0 8
test_database=# select * from orders;
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
  2 | My little database   |   500
  6 | WAL never lies       |   900
  8 | Dbiezdmin            |   501
(8 rows)

test_database=# select * from orders_1
test_database-# ;;
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)

test_database=# select * from orders_2;
 id |       title        | price 
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)

test_database=# DROP TABLE orders_old;
DROP TABLE
test_database=# \dt
                List of relations
 Schema |   Name   |       Type        |  Owner   
--------+----------+-------------------+----------
 public | orders   | partitioned table | postgres
 public | orders_1 | table             | postgres
 public | orders_2 | table             | postgres
(3 rows)
```

Исключить изначально "ручное" разбиение таблицы было бы возможно, если на этапе начального проектирования создать партиционированную таблицу.


# 4.


