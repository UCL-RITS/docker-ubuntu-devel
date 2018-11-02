About
=====

This is the base cppdev docker image (forked from [kernsuite-docker/base](https://github.com/kernsuite-docker/base)).

This Docker image is:
* Based on Ubuntu 18.10
* Has few cpp libraries needed for other projects.
* Has Universe, Multiverse and Restricted repo's enabled
* Has a docker-apt-install script which can be used
  to install debian package while keeping the Docker image
  clean and tiny.

You can manually build this image with `make build `or download it
from the docker hub with the name uclrits/cppdev:

usage: `$ docker run uclrits/base <cmd>`
