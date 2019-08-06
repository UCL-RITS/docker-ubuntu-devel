FROM ubuntu:16.04
LABEL maintainer="gijsmolenaar@gmail.com; d.perez-suarez@ucl.ac.uk"

ADD docker-apt-install /usr/local/bin

RUN docker-apt-install build-essential software-properties-common
RUN docker-apt-install byobu curl git htop man unzip vim wget cmake g++ zsh doxygen graphviz
RUN docker-apt-install libopenmpi1.10 libtiff5-dev libgomp1 libfftw3-dev libboost-all-dev libeigen3-dev

RUN add-apt-repository -y multiverse
RUN add-apt-repository -y restricted
