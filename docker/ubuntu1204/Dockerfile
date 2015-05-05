FROM ubuntu:12.04

RUN apt-get clean &&\
apt-get update &&\
apt-get install -y ruby1.9.1 ruby1.9.1-dev build-essential curl lsb-release &&\
gem install fpm-cookery --no-ri --no-rdoc &&\
apt-get install -y openjdk-7-jre-headless uuid-runtime &&\
apt-get clean
