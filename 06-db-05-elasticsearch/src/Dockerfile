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
