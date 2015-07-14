FROM ubuntu:12.04.5

RUN apt-get update &&\
apt-get install -y ruby1.9.1 ruby1.9.1-dev build-essential curl lsb-release &&\
gem install fpm-cookery --no-ri --no-rdoc &&\
apt-get install -y git-core unzip &&\
apt-get clean &&\
curl -sSL https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz \
	| tar xz -C /usr &&\
mkdir /gopath

ENV GOPATH /gopath
ENV GOROOT /usr/go
ENV PATH $PATH:/usr/go/bin
