About
=====

This is a docker container with the latest version (as of today) of
[dolfinx](https://github.com/FEniCS/dolfinx),
[bempp-cl](https://github.com/bempp/bempp-cl) and
[bempp-legacy](https://github.com/bempp/bempp-legacy).

The base docker image from
[dolfinx-complex](https://hub.docker.com/r/dolfinx/lab-complex).

This Docker image is:
* Based on Ubuntu 20.04
* Installs the dependencies for Bempp-legacy and Bempp-cl
* Bempp-cl has been renamed to be imported as `bemppcl`

You can manually build this image with `make build` or download it
from the docker hub with the name uclrits/bempp:20.04all

usage: `$ docker run uclrits/base <cmd>`

