# 1.

<img src="assets/06-db-03-mysql_001.png" width="800px">

<img src="assets/06-db-03-mysql_002.png" width="800px">

# 2.

```sql
CREATE USER IF NOT EXISTS 'test'@'%' IDENTIFIED WITH mysql_native_password BY 'test-pass'
WITH MAX_CONNECTIONS_PER_HOUR 100
PASSWORD EXPIRE INTERVAL 180 DAY
FAILED_LOGIN_ATTEMPTS 3
ATTRIBUTE '{"Lastname":"Pretty", "Name":"James"}';
```
```sql
GRANT SELECT ON test_db.* TO 'test'@'%';
```

```sql
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'test';
+------+------+-----------------------------------------+
| USER | HOST | ATTRIBUTE                               |
+------+------+-----------------------------------------+
| test | %    | {"Name": "James", "Lastname": "Pretty"} |
+------+------+-----------------------------------------+
1 row in set (0.00 sec)
```

```sql
mysql> SHOW GRANTS FOR 'test'@'%';
+-------------------------------------------+
| Grants for test@%                         |
+-------------------------------------------+
| GRANT USAGE ON *.* TO `test`@`%`          |
| GRANT SELECT ON `test_db`.* TO `test`@`%` |
+-------------------------------------------+
2 rows in set (0.00 sec)
```

# 3.

```sql
mysql> SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA='test_db';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.01 sec)
```
```sql
| 12 | 0.03054825 | ALTER TABLE test_db.orders ENGINE = MyISAM                                |
| 13 | 0.03221425 | ALTER TABLE test_db.orders ENGINE = InnoDB                                |
```

# 4.

```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

# Custom config should go here
!includedir /etc/mysql/conf.d/

innodb_flush_log_at_trx_commit = 0 # Скорость IO важнее сохранности данных
innodb_file_per_table = ON # Нужна компрессия таблиц для экономии места на диске
innodb_log_buffer_size = 1M # Размер буффера с незакомиченными транзакциями 1 Мб
innodb_buffer_pool_size = 1G # Буффер кеширования 30% от ОЗУ
innodb_log_file_size = 100M # Размер файла логов операций 100 Мб
```


