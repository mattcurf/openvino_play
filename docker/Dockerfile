FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=america/los_angeles

# #1 install base packages
#-----------------------
RUN apt update && \
  apt install --no-install-recommends -q -y \
    ca-certificates \
    clinfo \
    gnupg \
    libtbb12 \ 
    ocl-icd-libopencl1 \
    software-properties-common \
    wget

# #2 Install Intel GPU compute user-space drivers
#-----------------------
RUN mkdir -p /tmp/gpu && \
 cd /tmp/gpu && \
 wget https://github.com/oneapi-src/level-zero/releases/download/v1.16.1/level-zero_1.16.1+u22.04_amd64.deb && \
 wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.16510.2/intel-igc-core_1.0.16510.2_amd64.deb && \
 wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.16510.2/intel-igc-opencl_1.0.16510.2_amd64.deb && \
 wget https://github.com/intel/compute-runtime/releases/download/24.13.29138.7/intel-level-zero-gpu_1.3.29138.7_amd64.deb && \
 wget https://github.com/intel/compute-runtime/releases/download/24.13.29138.7/intel-opencl-icd_24.13.29138.7_amd64.deb && \
 wget https://github.com/intel/compute-runtime/releases/download/24.13.29138.7/libigdgmm12_22.3.18_amd64.deb && \
 dpkg -i *.deb && \
 rm *.deb

# Required compute runtime level-zero variables
ENV ZES_ENABLE_SYSMAN=1

# #3 Install intel NPU compute user-space drivers
RUN mkdir -p /tmp/npu && \
  cd /tmp/npu && \
  wget https://github.com/intel/linux-npu-driver/releases/download/v1.2.0/intel-driver-compiler-npu_1.2.0.20240404-8553879914_ubuntu22.04_amd64.deb && \
  wget https://github.com/intel/linux-npu-driver/releases/download/v1.2.0/intel-level-zero-npu_1.2.0.20240404-8553879914_ubuntu22.04_amd64.deb && \
  dpkg -i *.deb && \
  rm *.deb

