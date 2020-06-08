FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

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
      libpng-dev libboost-all-dev clinfo

RUN \
#    add-apt-repository ppa:intel-opencl/intel-opencl && apt-get update && \
    add-apt-repository ppa:ocl-dev/intel-opencl && apt-get update && \
    apt-get install -y --no-install-recommends libze-loader libze-loader-dev opencl-headers ocl-icd-opencl-dev libva-dev intel-opencl

RUN \
    cd /tmp && \
    git clone https://github.com/oneapi-src/level-zero-tests && \
    cd level-zero-tests && \
    git submodule update --init --recursive && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_INSTALL_PREFIX=$PWD/../out .. && \
    cmake --build . --config Release --target install -- -j $(nproc --all) && \
    cmake -D GROUP=/perf_tests -D CMAKE_INSTALL_PREFIX=$PWD/../out/perf_tests .. && \
    cmake --build . --config Release --target install -- -j $(nproc --all)

