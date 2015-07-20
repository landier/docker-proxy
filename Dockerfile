FROM ubuntu:latest
MAINTAINER Nicolas Landier <nicolas.landier@gmail.com>

ENV LOGSTASH_VERSION 1.5.2

RUN apt-get update && apt-get install -y supervisor squid3 openjdk-7-jre

RUN sed -i 's/http_access deny all/http_access allow all/g' /etc/squid3/squid.conf

ADD https://download.elastic.co/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz /tmp/
RUN tar -zxvf /tmp/logstash-${LOGSTASH_VERSION}.tar.gz
RUN logstash-${LOGSTASH_VERSION}/bin/plugin install logstash-filter-environment

COPY squid.conf /etc/supervisor/conf.d/squid.conf
COPY logstash.conf /etc/supervisor/conf.d/logstash.conf

COPY logstash-config.conf /logstash-${LOGSTASH_VERSION}/logstash-config.conf

EXPOSE 3128

CMD ["/usr/bin/supervisord", "-n"]
