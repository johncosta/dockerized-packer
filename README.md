## Overview
The intent of this project is to provide the artifacts and instructions to
create AMIs, prebuilt images, and virtual environments with [Docker][0]
pre-installed.

### Amazon AMI
Building Amazon AMIs is probably the most trivial out of each of these.

docker run -i -t -e=AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e=AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -b=`pwd`:/tmp/:ro 60290c5dff91


### Digital Ocean

### VirtualBox and VMWare



# do this in the environment that's running your containers
ntpdate ntp.ubuntu.com

2013/07/09 16:36:51 ui error: Build 'amazon-ebs' errored: Error creating temporary keypair: Get https://<omitted>: x509: failed to load system roots and no roots provided

List of base images
http://releases.ubuntu.com/

Mirror
#"iso_url": "http://ftp-stud.fht-esslingen.de/Mirrors/releases.ubuntu.com/13.04/ubuntu-13.04-server-amd64.iso",

TODO: 
  * is to build the image from a local build of docker, instead of the .deb

[0]: http://docker.io