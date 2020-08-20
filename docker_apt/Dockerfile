FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
      apt-utils \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common

RUN curl -L https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB | apt-key add - 

COPY intel-openvino-2020.list /etc/apt/sources.list.d

RUN apt-get update && apt-get install -y --no-install-recommends \
      intel-openvino-runtime-ubuntu18-2020.4.287
