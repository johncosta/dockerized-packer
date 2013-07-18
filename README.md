## Overview
The intent of this project is to provide the artifacts and instructions to
create AMIs, prebuilt images, and virtual environments with [Docker][0]
pre-installed.

### Amazon AMI
Building Amazon AMIs is probably the most trivial out of each of these.

#### Installation
I usually work with docker locally within a virtual box vm.  These instructions
are from this perspective.

1) create a new project directory

`mkdir -p /var/src/projects`

2) clone the repo

`https://github.com/johncosta/dockerized-packer.git`

3) cd to the project

`cd dockerized-packer`

4) Build an image or use the pre-built one

`

#### Configuration

1) Add the following to your environment

```
export AWS_ACCESS_KEY_ID=<your key>
export AWS_SECRET_ACCESS_KEY=<your secret>
```

#### Execution

Later versions of this docker image should have this repository cloned into it
so that we can avoid passing the -b param.  For now, because we're still working
on the configuraiton file, you CD to the directory specified and pass this in.
```
cd to /var/src/projects/dockerized-packer/aws
docker run -e=AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e=AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -b=`pwd`:/var/src/dockerized-packer/:rw johncosta/dockerized-packer
````

#### Common problems

1) Error creating temporary keypair

##### Issue
==> amazon-ebs: Error creating temporary keypair: Request has expired. Timestamp date is 2013-07-17T08:42:34Z (RequestExpired)

##### Solution
# do this in the environment that's running your containers
ntpdate ntp.ubuntu.com

2) Error creating temporary keypair
##### Issue
2013/07/09 16:36:51 ui error: Build 'amazon-ebs' errored: Error creating temporary keypair: Get https://<omitted>: x509: failed to load system roots and no roots provided

##### Solution
Installed golang into the image

### Digital Ocean
TODO

### VirtualBox and VMWare

To generate these, I've explored packer's features.  However, I have yet to be successful.  See: https://github.com/mitchellh/packer/issues/193


TODO: 
  * is to build the image from a local build of docker, instead of the .deb

[0]: http://docker.io