FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
      software-properties-common \
      ca-certificates \
      lsb-release \
      apt-utils \
      curl \
      gnupg-agent \
      libva-x11-2 \
      libva-drm2 \
      xorg 

RUN curl -L https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB | apt-key add - && \
   echo "deb https://apt.repos.intel.com/openvino/2020 all main" | tee /etc/apt/sources.list.d/intel-openvino-2020.list && \
   echo "deb [trusted=yes arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main" | tee /etc/apt/sources.list.d/intel-graphics.list && \
   apt-get update && apt-get install -y --no-install-recommends \
      intel-openvino-runtime-ubuntu18-2020.4.287 \
      intel-opencl-icd \
      intel-media-va-driver-non-free \
      libmfx1 \
      libmfx-tools \
      clinfo
