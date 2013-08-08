#!/usr/bin/env sh

# The purpose of this script is to build revision specific version of docker.  

export DOCKER_COMMIT_ID=d67d5dd

# Update image dependencies
for attempt in 1 2 3 4 5; do
  if [ ! -z "`which git`" ]; then
    break
  fi
  echo "Trying to install git, attempt $attempt"
  sudo apt-get update -yq --fix-missing
  sudo apt-get install -yq git curl linux-image-extra-virtual lxc
done

# Install go
curl -s https://go.googlecode.com/files/go1.1.1.linux-amd64.tar.gz | sudo tar -v -C /usr/local -xz

# will need to sort out the correct permissions
sudo chown -R root:adm /usr/local/go
sudo chmod -R 777 /usr/local/go

. ~/.bashrc

cd /tmp && echo 'package main' > t.go && /usr/local/go/bin/go test -a -i -v

sudo mkdir -p /go/src
sudo chown -R root:adm /go
sudo chown -R ubuntu:ubuntu /go

PKG=github.com/kr/pty REV=27435c699; git clone http://$PKG /go/src/$PKG && cd /go/src/$PKG && git checkout
PKG=github.com/gorilla/context/ REV=708054d61e5; git clone http://$PKG /go/src/$PKG && cd /go/src/$PKG && git checkout
PKG=github.com/gorilla/mux/ REV=9b36453141c; git clone http://$PKG /go/src/$PKG && cd /go/src/$PKG && git checkout

sudo apt-get install -y iptables
sudo echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' | sudo tee -a /etc/apt/sources.list
sudo apt-get update

PKG=github.com/dotcloud/docker/ REV=d67d5dd; git clone http://$PKG /go/src/$PKG && cd /go/src/$PKG && git checkout
printenv > ~/temp

env - GOROOT=/usr/local/go GOPATH=/go CGO_ENABLED=0 PATH=$PATH:/usr/local/go/bin /bin/bash -c 'cd /go/src/github.com/dotcloud/docker/docker && /usr/local/go/bin/go install -ldflags "-X main.GITCOMMIT '??' -d -w"'

#cat <<'EOF' >> ~/.bashrc
#export PATH=$PATH:/usr/local/go/bin:/go/bin
#EOF

# Create the upstart config
cat <<'EOF' >> ~/docker.upstart
description     "Run docker"

start on filesystem or runlevel [2345]
stop on runlevel [!2345]

respawn

exec /usr/bin/docker -d
EOF

# install executeable
sudo install -m 0755 /go/bin/docker /usr/bin
sudo install -o root -m 0644 ~/docker.upstart /etc/init/docker.conf

