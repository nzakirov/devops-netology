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


Ответ ```elasticsearch```:
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


