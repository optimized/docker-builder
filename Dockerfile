FROM debian:stretch
MAINTAINER Noël Jackson <n@noeljackson.com

RUN apt-get update && apt-get install -y \
  gcc \
  libc6-dev \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

RUN  apt-get update && apt-get -y install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && \
    apt-get -y install docker-ce

RUN usermod -aG docker root

WORKDIR /usr/src/app
