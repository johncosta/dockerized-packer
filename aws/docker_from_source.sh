#!/usr/bin/env sh

# http://stackoverflow.com/questions/12438946/e-unable-to-locate-package-git-ubuntu-on-ec2
# stupid loop to get around ubuntu package mirror problems
for attempt in 1 2 3 4 5; do
  if [ ! -z "`which git`" ]; then
    break
  fi
  echo "Trying to install git, attempt $attempt"
  sudo apt-get update -yq --fix-missing
  sudo apt-get install -yq git curl
done


curl -s https://go.googlecode.com/files/go1.1.1.linux-amd64.tar.gz | sudo tar -v -C /usr/local -xz
# will need to sort out the correct permissions
sudo chown -R root:adm /usr/local/go
sudo chmod -R 777 /usr/local/go

#cat <<'EOF' >> ~/.bashrc 
#export PATH=$PATH:/usr/local/go/bin
#export GOROOT=/usr/local/go
#export GOPATH=/go
#export CGO_ENABLED=0
#EOF

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

cat <<'EOF' >> ~/.bashrc
export PATH=$PATH:/usr/local/go/bin:/go/bin
EOF

