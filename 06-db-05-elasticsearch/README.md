# 1.

Dockerfile:

```
FROM centos:7
WORKDIR /app
ENV PATH=/usr/lib:$PATH

RUN yum install java-11-openjdk -y
RUN yum install wget -y

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.4-linux-x86_64.tar.gz \
  && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.4-linux-x86_64.tar.gz.sha512
RUN yum install perl-Digest-SHA -y
RUN shasum -a 512 -c elasticsearch-7.17.4-linux-x86_64.tar.gz.sha512 \
  && tar -xzf elasticsearch-7.17.4-linux-x86_64.tar.gz  \
  && yum upgrade -y

#COPY elasticsearch.yml /app/elasticsearch-7.17.4/config/
ENV JAVA_HOME=/app/elasticsearch-7.17.4/jdk/
ENV ES_HOME=/app/elasticsearch-7.17.4
RUN groupadd elasticsearch \
  && useradd -g elasticsearch elasticsearch

RUN mkdir /var/lib/logs \
  && chown elasticsearch:elasticsearch /var/lib/logs \
  && mkdir  /var/lib/data \
  && chown elasticsearch:elasticsearch /var/lib/data \
  && chown -R elasticsearch:elasticsearch /app/elasticsearch-7.17.4/
RUN mkdir  /app/elasticsearch-7.17.4/snapshots \
  && chown elasticsearch:elasticsearch /app/elasticsearch-7.17.4/snapshots

USER elasticsearch
CMD ["/usr/sbin/init"]
CMD ["/app/elasticsearch-7.17.4/bin/elasticsearch"]
```

Образ в репозитории [docker hub](https://hub.docker.com/repository/docker/nzakirov/elasticsearch)

Запускаем elasticsearch посредством docker-compose:

```yaml
version: "3.3"


services:
  elasticsearch:
    image: nzakirov/elasticsearch:7.17.4
    volumes:
      - ./elasticsearch.yml:/app/elasticsearch-7.17.4/config/elasticsearch.yml
    ports:
      - "9200:9200"
      - "9300:9300"
```


Ответ elasticsearch:
```json
{
  "name" : "24192bbd8bbe",
  "cluster_name" : "netology_test",
  "cluster_uuid" : "bg_jCncETaCy6H7Uc7kz2Q",
  "version" : {
    "number" : "7.17.4",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "79878662c54c886ae89206c685d9f1051a9d6411",
    "build_date" : "2022-05-18T18:04:20.964345128Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

# 2.

```
❯ curl -X PUT "localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d' \
{ "settings": { "index": { "number_of_shards": 1, "number_of_replicas": 0} } } '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-1"
}
```

```
❯ curl -X PUT "localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d' \
{   "settings": {     "index": {       "number_of_shards": 2, "number_of_replicas": 1} } } '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-2"
}
```

```
❯ curl -X PUT "localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d' \
{   "settings": {     "index": {       "number_of_shards": 4, "number_of_replicas": 2} } } '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-3"
}
```

Список индексов и их статусы:
```
❯ curl 'localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases TAzotmQdRoGNNNc3QHEjpA   1   0         41            0     38.8mb         38.8mb
green  open   ind-1            9Hz-WNOcRw69nO4DuABDWQ   1   0          0            0       226b           226b
yellow open   ind-3            4s40jxt0Qf2-UfojtGX8yg   4   2          0            0       904b           904b
yellow open   ind-2            KTwbGshFQP2uMA0H9Hx8nQ   2   1          0            0       452b           452b
```

Состояние кластера:
```
❯ curl 'localhost:9200/_cluster/health?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 10,
  "active_shards" : 10,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}
```

*Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?*

Потому, что у некоторых индекстов объявлено ненулевое количество реплик, а количество активных нод всего 1.

Удаление индексов:

```
❯ curl -X DELETE "localhost:9200/ind-1?pretty"
{
  "acknowledged" : true
}

❯ curl -X DELETE "localhost:9200/ind-2?pretty"
{
  "acknowledged" : true
}

❯ curl -X DELETE "localhost:9200/ind-3?pretty"
{
  "acknowledged" : true
}
```

# 3.

```
❯ curl -XPOST "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'{"type": "fs",  "settings": { "location":"/app/elasticsearch-7.17.4/snapshots" }}'
{
  "acknowledged" : true
}
```

 ```
 ❯ curl -XGET 'http://localhost:9200/_snapshot/netology_backup?pretty'
{
  "netology_backup" : {
    "type" : "fs",
    "settings" : {
      "location" : "/app/elasticsearch-7.17.4/snapshots"
    }
  }
}
 ```

```
❯ curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d' {   "settings": {     "index": {       "number_of_shards": 1, "number_of_replicas": 0} } } '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test"
}
```

```
❯ curl 'localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases TAzotmQdRoGNNNc3QHEjpA   1   0         41            0     38.8mb         38.8mb
green  open   test             abZqh8zWS7GwYOWM28bTRA   1   0          0            0       226b           226b
```

```
❯ curl -X PUT "localhost:9200/_snapshot/netology_backup/my_test?wait_for_completion=true"
{"snapshot":{"snapshot":"my_test","uuid":"ro6aAZJhQNSqoZiHYf0g1g","repository":"netology_backup","version_id":7170499,"version":"7.17.4","indices":[".ds-ilm-history-5-2022.06.11-000001",".geoip_databases","test",".ds-.logs-deprecation.elasticsearch-default-2022.06.11-000001"],"data_streams":["ilm-history-5",".logs-deprecation.elasticsearch-default"],"include_global_state":true,"state":"SUCCESS","start_time":"2022-06-11T19:32:54.822Z","start_time_in_millis":1654975974822,"end_time":"2022-06-11T19:32:56.023Z","end_time_in_millis":1654975976023,"duration_in_millis":1201,"failures":[],"shards":{"total":4,"failed":0,"successful":4},"feature_states":[{"feature_name":"geoip","indices":[".geoip_databases"]}]}}%
```

```
[elasticsearch@156fc829eda4 snapshots]$ pwd
/app/elasticsearch-7.17.4/snapshots

[elasticsearch@156fc829eda4 snapshots]$ ll
total 0

[elasticsearch@156fc829eda4 snapshots]$ ll
total 48
-rw-r--r-- 1 elasticsearch elasticsearch  1419 Jun 11 19:32 index-0
-rw-r--r-- 1 elasticsearch elasticsearch     8 Jun 11 19:32 index.latest
drwxr-xr-x 6 elasticsearch elasticsearch  4096 Jun 11 19:32 indices
-rw-r--r-- 1 elasticsearch elasticsearch 29299 Jun 11 19:32 meta-ro6aAZJhQNSqoZiHYf0g1g.dat
-rw-r--r-- 1 elasticsearch elasticsearch   706 Jun 11 19:32 snap-ro6aAZJhQNSqoZiHYf0g1g.dat
```

```
❯ curl -X DELETE 'http://localhost:9200/test?pretty'
{
  "acknowledged" : true
}
❯ curl 'localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases tr68ACThQaCksdLaq5-9Jg   1   0         41            0     38.8mb         38.8mb
```

```
❯ curl -X PUT "localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d' {   "settings": {     "index": {       "number_of_shards": 1, "number_of_replicas": 0} } } '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}
❯ curl 'localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases tr68ACThQaCksdLaq5-9Jg   1   0         41            0     38.8mb         38.8mb
green  open   test-2           OeF8d1RsTm-QtIchdewiKg   1   0          0            0       226b           226b
```

```
❯ curl -X POST "localhost:9200/_snapshot/netology_backup/my_test/_restore?pretty" -H 'Content-Type: application/json' -d' {   "indices": "test" } '
{
  "accepted" : true
}
❯ curl 'localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases tr68ACThQaCksdLaq5-9Jg   1   0         41            0     38.8mb         38.8mb
green  open   test-2           OeF8d1RsTm-QtIchdewiKg   1   0          0            0       226b           226b
green  open   test             dOx6JC5hTWiQcDkznd91lw   1   0          0            0       226b           226b
```
