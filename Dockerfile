FROM ubuntu:14.04
MAINTAINER Terry Chen <seterrychen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get install -y apt-mirror apache2 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

VOLUME ["/etc/apt/"]

EXPOSE 80
COPY setup.sh /setup.sh
CMD /bin/bash setup.sh
