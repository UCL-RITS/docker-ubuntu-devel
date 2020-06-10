FROM dolfinx/lab-complex:latest
LABEL maintainer="d.perez-suarez@ucl.ac.uk"

ADD docker-apt-install /usr/local/bin

# Install old and new bempp dependencies
RUN docker-apt-install  dh-make gcc g++ gfortran cmake patchelf \
                        libeigen3-dev libtbb-dev zlib1g-dev libboost-all-dev cpio \
                        # Ignored as it's version 2.6 and we don't know whether that works. NOTE brace expansion doesn't work here
                        # libdune-{common-dev,geometry-dev,grid-dev,localfunctions-dev} \
                        # Many deprecation warnings, but without it, it doesn't build.
                        libtbb2 \
                        mpi-default-dev libopenmpi-dev \
                        python3-dev \
                        # new bempp
                        python3-pip python3-venv python3-matplotlib python3-tk \
                        libpcre3 libpcre3-dev software-properties-common \
                        llvm-9 llvm-9-dev llvm-9-runtime && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    pip3 install --upgrade pip cython pyopencl numba


# Install old bempp
RUN git clone https://github.com/bempp/bempp-legacy.git && \
    cd bempp-legacy && \
    sed -i '/cmd = gmsh_command/c \        cmd = gmsh_command + " -2 -format msh22 " + geo_name' ./python/bempp/api/shapes/shapes.py && \
    pip3 install --upgrade -b ./build --target /usr/local/lib/python3.8/dist-packages . && \
    cd /root && rm -rf bempp-legacy

# Install new bempp - renamed as bemppcl
RUN git clone https://github.com/bempp/bempp-cl.git && \
    cd bempp-cl && \
    find ./ -type f -iname "*py" \( -exec sed -i -e "s/from bempp /from bemppcl /" \
                                                 -e "s/from bempp\./from bemppcl\./" \
                                                 -e "s/import bempp$/import bemppcl/" {} \; \) && \
    sed -i '/cmd = gmsh_command/c \        cmd = gmsh_command + " -2 -format msh22 " + geo_name' ./bempp/api/shapes/shapes.py && \
    mv bempp bemppcl && \
    pip3 install . && \
    cd /root && rm -rf bempp-cl

