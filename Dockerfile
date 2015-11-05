FROM ubuntu:14.04
MAINTAINER Terry Chen <seterrychen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TIMEOUT 12h
ENV MIRROR_URL http://archive.ubuntu.com/ubuntu

RUN \
  apt-get update && \
  apt-get install -y apt-mirror apache2 && \
  apt-get clean && \
  mv /etc/apt/mirror.list / && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 80
COPY setup.sh /setup.sh

VOLUME ["/etc/apt", "/var/spool/apt-mirror"]
CMD ["/bin/bash", "setup.sh"]
