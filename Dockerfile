FROM ubuntu
MAINTAINER John Costa <john.costa@gmail.com>

RUN apt-get update
RUN apt-get install -y wget unzip 

RUN wget --no-check-certificate https://dl.bintray.com/mitchellh/packer/0.1.5_linux_amd64.zip?direct
RUN unzip 0.1.5_linux_amd64.zip?direct -d /usr/bin
RUN rm -rf 0.1.5_linux_amd64.zip?direct

CMD /usr/bin/packer build /tmp/provisioning.json
