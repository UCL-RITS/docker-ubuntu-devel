FROM ubuntu:xenial
LABEL maintainer="d.perez-suarez@ucl.ac.uk"

ADD docker-apt-install /usr/local/bin
RUN docker-apt-install build-essential software-properties-common

RUN add-apt-repository -y multiverse
RUN add-apt-repository -y restricted
RUN add-apt-repository -y ppa:bemppsolutions/bempp

RUN docker-apt-install byobu curl git htop man unzip bzip2 vim wget cmake g++ zsh less
RUN docker-apt-install openssh-client ca-certificates locales
RUN docker-apt-install libdune-geometry-dev \
                       libdune-common-dev \
                       libdune-grid-dev \
                       libdune-localfunctions-dev
RUN docker-apt-install python3-scipy \
                       python3-pip \
                       libopenblas-base

RUN add-apt-repository -y ppa:fenics-packages/fenics
RUN apt-get update
RUN docker-apt-install fenics python3-bempp

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENV NB_USER bempp
ENV NB_UID 1000
ENV SHELL /bin/bash
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV PATH="/home/bempp/.local/bin:${PATH}"

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER
ENTRYPOINT ["tini", "--"]

USER $NB_USER

RUN pip3 install -U matplotlib numpy scipy pytest

RUN mkdir /home/$NB_USER/work && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

WORKDIR /home/$NB_USER/work

CMD ["bash"]
