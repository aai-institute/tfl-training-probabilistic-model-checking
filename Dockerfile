FROM jupyter/minimal-notebook:python-3.11

USER root

# pandoc needed for docs, see https://nbsphinx.readthedocs.io/en/0.7.1/installation.html?highlight=pandoc#pandoc
# gh-pages action uses rsync
RUN apt-get update -qq  && apt-get upgrade -y && apt-get -y install pandoc git-lfs rsync

USER ${NB_UID}

COPY build_scripts build_scripts
RUN bash build_scripts/install_presentation_requirements.sh

COPY requirements-test.txt .
RUN pip install -r requirements-test.txt

COPY requirements.txt .
RUN pip install -r requirements.txt


# Start of HACK: the home directory is overwritten by a mount when a jhub server is started off this image
# Thus, we create a jovyan-owned directory to which we copy the code and then move it to the home dir as part
# of the entrypoint
ENV CODE_DIR=/tmp/code

RUN mkdir $CODE_DIR

COPY --chown=${NB_UID}:${NB_GID} entrypoint.sh $CODE_DIR

RUN chmod +x "${CODE_DIR}/"entrypoint.sh
# Unfortunately, we cannot use ${CODE_DIR} in the ENTRYPOINT directive, so we have to hardcode it
# Keep in sync with the value of CODE_DIR above
ENTRYPOINT ["/tmp/code/entrypoint.sh"]

# End of HACK

WORKDIR "${HOME}"

COPY --chown=${NB_UID}:${NB_GID} . $CODE_DIR

# Storm related setup
USER root

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
# - ca-certificates is needed for cloning from Github
# - all other dependencies are the recommended packages for Storm (see https://www.stormchecker.org/documentation/obtain-storm/dependencies.html#-debian-and--ubuntu)
RUN apt-get install --fix-missing -y --no-install-recommends \
    ca-certificates \
    build-essential \
    git \
    cmake \
    libboost-all-dev \
    libcln-dev \
    libgmp-dev \
    libginac-dev \
    automake \
    libglpk-dev \
    libhwloc-dev \
    libz3-dev \
    libxerces-c-dev \
    libeigen3-dev


# Specify number of threads to use for parallel compilation
# This number can be set from the commandline with:
# --build-arg no_threads=<value>
ARG no_threads=1


# Build Carl
############
# Explicitly build the Carl library
# This is needed when using pycarl/stormpy later on
WORKDIR /opt/

# Obtain Carl from public repository
RUN git clone https://github.com/moves-rwth/carl-storm.git carl

# Switch to build directory
RUN mkdir -p /opt/carl/build
WORKDIR /opt/carl/build

# Configure Carl
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DUSE_CLN_NUMBERS=ON -DUSE_GINAC=ON -DTHREAD_SAFE=ON

# Build Carl library
RUN make lib_carl -j $no_threads

# Build Storm
#############
WORKDIR /opt/

# Obtain storm from public repository
RUN git clone https://github.com/moves-rwth/storm.git storm --branch 1.8.1
WORKDIR /opt/storm

# Switch to build directory
RUN mkdir -p /opt/storm/build
WORKDIR /opt/storm/build

# Configure Storm
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DSTORM_DEVELOPER=OFF -DSTORM_LOG_DISABLE_DEBUG=ON -DSTORM_PORTABLE=ON -DSTORM_USE_SPOT_SHIPPED=ON

# Build external dependencies of Storm
RUN make resources -j $no_threads

# Build Storm binary
RUN make storm -j $no_threads

# Build additional binaries of Storm
# (This can be skipped or adapted dependending on custom needs)
RUN make binaries -j $no_threads

# Set path
ENV PATH="/opt/storm/build/bin:$PATH"

# Install dependencies
######################
# Uncomment to update packages beforehand
# RUN apt-get update -qq


RUN apt-get install -y --no-install-recommends \
    maven \
    uuid-dev \
    python3 \
    python3-pip
# Packages maven and uuid-dev are required for carl-parser
ENV CMAKE_PREFIX_PATH="/opt/carl/build:$CMAKE_PREFIX_PATH"

# Build carl-parser
###################
WORKDIR /opt/

# Obtain carl-parser from public repository
RUN git clone -b master14 https://github.com/ths-rwth/carl-parser.git

# Switch to build directory
RUN mkdir -p /opt/carl-parser/build
WORKDIR /opt/carl-parser/build

# Configure carl-parser
RUN cmake .. -DCMAKE_BUILD_TYPE=Release

# Build carl-parser
RUN make carl-parser -j $no_threads

# Build pycarl
##############
WORKDIR /opt/

# Obtain latest version of pycarl from public repository
RUN git clone https://github.com/moves-rwth/pycarl.git

# Switch to pycarl directory
WORKDIR /opt/pycarl

# Build pycarl
RUN python3 setup.py build_ext -j $no_threads develop

# Build stormpy
###############
WORKDIR /opt/

# Obtain stormpy from public repository
RUN git clone https://github.com/moves-rwth/stormpy.git --branch 1.8.0
WORKDIR /opt/stormpy

# Build stormpy,
RUN python3 setup.py build_ext -j $no_threads develop

USER ${NB_UID}
WORKDIR "${HOME}"

EXPOSE 8888
CMD [ "jupyter", "notebook" ]
