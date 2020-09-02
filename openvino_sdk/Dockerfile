FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
      software-properties-common \
      ca-certificates \
      lsb-release \
      apt-utils \
      cpio \
      wget \
      gnupg-agent \
      libva-x11-2 \
      libva-drm2 \
      xorg

RUN echo "deb [trusted=yes arch=amd64] https://repositories.intel.com/graphics/ubuntu bionic main" | tee /etc/apt/sources.list.d/intel-graphics.list && \
   apt-get update && apt-get install -y --no-install-recommends \
      intel-opencl \
      clinfo

ARG DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/16670/l_openvino_toolkit_p_2020.3.194.tgz
ARG INSTALL_DIR=/opt/intel/openvino
ARG TEMP_DIR=/tmp/openvino_installer

RUN \
  mkdir -p $TEMP_DIR && cd $TEMP_DIR && \
  wget -c $DOWNLOAD_LINK && \
  tar xf l_openvino_toolkit*.tgz && \
  cd l_openvino_toolkit* && \
  sed -i 's/decline/accept/g' silent.cfg && \
  ./install.sh -s silent.cfg && \
  $INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh 
