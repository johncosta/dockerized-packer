# Docker file used for building Amazon AMIs
FROM ubuntu:12.04
MAINTAINER John Costa <john.costa@gmail.com>

RUN apt-get update
RUN apt-get install -y python-software-properties
RUN add-apt-repository -y ppa:gophers/go 
RUN apt-get update
RUN apt-get install -y wget unzip golang-stable 

RUN wget --no-check-certificate https://dl.bintray.com/mitchellh/packer/0.1.5_linux_amd64.zip?direct && unzip 0.1.5_linux_amd64.zip?direct -d /usr/bin && rm -rf 0.1.5_linux_amd64.zip?direct

CMD /usr/bin/packer build /var/src/dockerized-packer/aws/provisioning.json
