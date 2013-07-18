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

Either `docker pull johncosta/dockerized-packer` or `cd /var/src/projects/dockerized-packer/aws; docker build - < Dockerfile`

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

Update your VM's system datetime: `ntpdate ntp.ubuntu.com`

2) Error creating temporary keypair

##### Issue

2013/07/09 16:36:51 ui error: Build 'amazon-ebs' errored: Error creating temporary keypair: Get https://<omitted>: x509: failed to load system roots and no roots provided

##### Solution

Installed golang into the image

### Digital Ocean
TODO

### VirtualBox and VMWare

To generate these, I've explored packer's features.  However, I have yet to be successful.  See: https://github.com/mitchellh/packer/issues/193

#### Installation

1) Checkout the veewee code base; this has the templates.

`git clone https://github.com/jedi4ever/veewee.git`

2) Install veewee-to-packer: https://github.com/mitchellh/veewee-to-packer

3) Convert the template your looking to use:

`veewee-to-packer /Users/jcosta/projects/veewee/templates/ubuntu-12.04.2-server-amd64-netboot/definition.rb`

This produces an output directory with your packer artifacts: /Users/jcosta/projects/veewee/output

4) Modify the provisioners section of the template.json file to have the full path of for the scripts listed. See [issue #54][1]

`"/full/path/to/scripts/postinstall.sh"`

5) Modify each builder definition to include an "iso_md5" key/value pair.

`"iso_md5": "1278936cb0ee9d9a32961dd7743fa75c",`

6) Now use packer to build the image

`./packer build /full/path/to/output/template.json`

TODO:
  * where/how should artifcats be made available?
  * is there a process to publish AMIs?
  * is to build the image from a local build of docker, instead of the .deb

[0]: http://docker.io
[1]: https://github.com/mitchellh/packer/issues/54