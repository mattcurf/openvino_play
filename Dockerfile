FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
      software-properties-common \
      ca-certificates \
      lsb-release \
      apt-utils \
      wget \
      gnupg-agent \
      libva-x11-2 \
      libva-drm2 \
      xorg 

# Install oneVPL
RUN wget -qO - https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB | apt-key add - && \
  add-apt-repository "deb https://apt.repos.intel.com/oneapi all main" && \
   apt-get update && apt-get install -y --no-install-recommends \
   intel-oneapi-onevpl

# Install Intel Graphics media runtime driver, for oneVPL
RUN wget -qO - https://repositories.intel.com/graphics/intel-graphics.key | apt-key add - && \
  echo "deb [arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main" > /etc/apt/sources.list.d/intel-graphics.list && \ 
  apt-get update && apt-get install -y --no-install-recommends \
      intel-opencl-icd \
      intel-media-va-driver-non-free \
      libmfx1 \
      libmfx-tools 

# Install OpenVINO
RUN echo "deb https://apt.repos.intel.com/openvino/2021 all main" | tee /etc/apt/sources.list.d/intel-openvino-2021.list && \
   apt-get update && apt-get install -y --no-install-recommends \
      intel-openvino-runtime-ubuntu20-2021.1.110

# Install optional developer packages for OpenVINO and oneVPL 
RUN apt-get update && apt-get install -y --no-install-recommends \
   intel-oneapi-onevpl-devel \
   intel-openvino-dev-ubuntu20-2021.1.110
