FROM quay.io/pires/docker-jre:8u74-dns
MAINTAINER pjpires@gmail.com

# Export HTTP & Transport
EXPOSE 9200 9300

ENV VERSION 1.7.5

# Install Elasticsearch.
RUN apk add --update curl ca-certificates sudo && \
  ( curl -Lskj https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz | \
  gunzip -c - | tar xf - ) && \
  mv /elasticsearch-$VERSION /elasticsearch && \
  rm -rf $(find /elasticsearch | egrep "(\.(exe|bat)$|sigar/.*(dll|winnt|x86-linux|solaris|ia64|freebsd|macosx))") && \
  apk del curl wget

# Volume for Elasticsearch data
VOLUME ["/data"]

# Copy configuration
COPY config /elasticsearch/config

# Copy run script
COPY run.sh /

CMD ["/run.sh"]
