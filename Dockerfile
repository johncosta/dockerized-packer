FROM ubuntu:12.04
MAINTAINER John Costa <john.costa@gmail.com>

RUN apt-get update
#RUN apt-get install -y dkms
RUN apt-get install -y python-software-properties
RUN add-apt-repository -y ppa:gophers/go 
RUN apt-get update
RUN apt-get install -y wget unzip golang-stable 

# for virtual box support
RUN wget -c download.virtualbox.org/virtualbox/4.2.14/virtualbox-4.2_4.2.14-86644~Ubuntu~raring_amd64.deb
RUN dpkg -i virtualbox-4.2_4.2.14-86644~Ubuntu~raring_amd64.deb || apt-get -fy install

RUN wget --no-check-certificate https://dl.bintray.com/mitchellh/packer/0.1.5_linux_amd64.zip?direct && unzip 0.1.5_linux_amd64.zip?direct -d /usr/bin && rm -rf 0.1.5_linux_amd64.zip?direct

CMD /usr/bin/packer build /var/src/dockerized-packer/provisioning.json
