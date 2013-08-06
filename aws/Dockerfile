# Docker file used for building Amazon AMIs
FROM ubuntu:12.04
MAINTAINER John Costa <john.costa@gmail.com>

RUN apt-get update
RUN apt-get install -y python-software-properties
RUN add-apt-repository -y ppa:gophers/go 
RUN apt-get update
RUN apt-get install -y wget unzip golang-stable 

ENV PACKER_VERSION 0.2.1
RUN echo $PACKER_VERSION
RUN wget --no-check-certificate https://dl.bintray.com/mitchellh/packer/$PACKER_VERSION\_linux_amd64.zip?direct && unzip $PACKER_VERSION\_linux_amd64.zip?direct -d /usr/bin && rm -rf $PACKER_VERSION\_linux_amd64.zip?direct

# TODO: clone dockerized packer to avoid passing -b
CMD /usr/bin/packer build /var/src/dockerized-packer/provisioning.json
