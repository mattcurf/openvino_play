FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=america/los_angeles
# Base packages
RUN apt update && \
    apt install --no-install-recommends -q -y \
    build-essential \
    ocl-icd-libopencl1 \
    software-properties-common \
    python3 \
    python3-dev \
    python3-pip \
    libtbb12 \
    wget 

# Intel GPU compute user-space drivers
RUN mkdir -p /tmp/gpu && \
 cd /tmp/gpu && \
 wget https://github.com/oneapi-src/level-zero/releases/download/v1.17.19/level-zero_1.17.19+u22.04_amd64.deb && \
 wget https://github.com/oneapi-src/level-zero/releases/download/v1.16.1/level-zero_1.16.1+u22.04_amd64.deb && \
 wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.17193.4/intel-igc-core_1.0.17193.4_amd64.deb && \
 wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.17193.4/intel-igc-opencl_1.0.17193.4_amd64.deb && \
 wget https://github.com/intel/compute-runtime/releases/download/24.26.30049.6/intel-level-zero-gpu_1.3.30049.6_amd64.deb && \
 wget https://github.com/intel/compute-runtime/releases/download/24.26.30049.6/intel-opencl-icd_24.26.30049.6_amd64.deb && \
 wget https://github.com/intel/compute-runtime/releases/download/24.26.30049.6/libigdgmm12_22.3.20_amd64.deb && \
 dpkg -i *.deb && \
 rm *.deb

# Intel NPU compute user-space drivers
RUN mkdir -p /tmp/npu && \
  cd /tmp/npu && \
  wget https://github.com/oneapi-src/level-zero/releases/download/v1.17.6/level-zero_1.17.6+u22.04_amd64.deb && \
  wget https://github.com/intel/linux-npu-driver/releases/download/v1.5.1/intel-driver-compiler-npu_1.5.1.20240708-9842236399_ubuntu22.04_amd64.deb && \
  wget https://github.com/intel/linux-npu-driver/releases/download/v1.5.1/intel-level-zero-npu_1.5.1.20240708-9842236399_ubuntu22.04_amd64.deb && \
  dpkg -i *.deb && \
  rm *.deb

# OpenVINO via package
RUN mkdir -p /opt/intel && \
  wget https://storage.openvinotoolkit.org/repositories/openvino/packages/2024.3/linux/l_openvino_toolkit_ubuntu22_2024.3.0.16041.1e3b88e4e3f_x86_64.tgz --output-document openvino_2024.3.0.tgz && \
  tar xf openvino_2024.3.0.tgz && \
  rm openvino_2024.3.0.tgz && \
  mv l_openvino_toolkit_ubuntu22_2024.3.0.16041.1e3b88e4e3f_x86_64 /opt/intel/openvino_2024.3.0 && \
  cd /opt/intel/openvino_2024.3.0  && \
  ./install_dependencies/install_openvino_dependencies.sh -y && \
  python3 -m pip install --upgrade pip && \
  python3 -m pip install -r ./python/requirements.txt torch torchvision nncf 

RUN /bin/bash -c "source /opt/intel/openvino_2024.3.0/setupvars.sh && \
  /opt/intel/openvino_2024.3.0/samples/cpp/build_samples.sh"
