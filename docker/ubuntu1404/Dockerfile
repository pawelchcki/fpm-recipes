FROM ubuntu:14.04

RUN apt-get clean &&\
apt-get update &&\
apt-get install -y ruby1.9.1 ruby1.9.1-dev build-essential curl lsb-release &&\
gem install fpm-cookery --no-ri --no-rdoc &&\
apt-get install -y git-core unzip &&\
apt-get clean &&\
curl -sSL https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz \
	| tar xz -C /usr &&\

mkdir /gopath
