FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

# System defaults
RUN apt-get update && apt-get install -y --no-install-recommends \
      software-properties-common \
      build-essential \
      wget \
      cpio \
      sudo \
      git \
      cmake \
      libgtest-dev \
      lsb-release \
      clang-format-7 \
      google-mock \
      opencl-headers \
      libva-dev \
      libpng-dev libboost-all-dev clinfo

# NEO and Level Zero dependencies and runtime
RUN \
    add-apt-repository ppa:ocl-dev/intel-opencl && apt-get update && \
    apt-get install -y --no-install-recommends libze-loader libze-loader-dev ocl-icd-opencl-dev && \
    cd /tmp && \
    mkdir neo && \
    cd neo && \
    wget https://github.com/intel/compute-runtime/releases/download/20.22.16952/intel-gmmlib_20.1.1_amd64.deb && \
    wget https://github.com/intel/compute-runtime/releases/download/20.22.16952/intel-igc-core_1.0.4062_amd64.deb && \ 
    wget https://github.com/intel/compute-runtime/releases/download/20.22.16952/intel-igc-opencl_1.0.4062_amd64.deb && \
    wget https://github.com/intel/compute-runtime/releases/download/20.22.16952/intel-opencl_20.22.16952_amd64.deb && \
    wget https://github.com/intel/compute-runtime/releases/download/20.22.16952/intel-ocloc_20.22.16952_amd64.deb && \
    wget https://github.com/intel/compute-runtime/releases/download/20.22.16952/intel-level-zero-gpu_0.8.16952_amd64.deb && \
    dpkg -i *.deb

# Level Zero Tests and Peformance
RUN \
    cd /tmp && \
    git clone https://github.com/oneapi-src/level-zero-tests && \
    cd level-zero-tests && \
    git submodule update --init --recursive && \
    cd /tmp/level-zero-tests && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_INSTALL_PREFIX=$PWD/../out .. && \
    cmake --build . --config Release --target install -- -j $(nproc --all) 

