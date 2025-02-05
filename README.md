# openvino_play

This repo demonstrates the setup of all required Intel GPU and NPU user-space drivers for use with OpenVINO 2024.4 and Linux. It has been tested on a Intel 13th Gen Intel(R) Core(TM) i9-13900H,  Intel(R) Core(TM) Ultra 5 125H processor, Intel(R) Core(TM) Ultra 7 258V processor, Intel(R) Core(TM) Ultra 7 265K, and 13th Gen Intel(R) Core(TM) i9-19700K with Intel(R) ARC A770 Discrete GPU

## Prerequisite
* Ubuntu 24.04 with kernel 6.8.0-36-generic or newer (for Intel GPU kernel driver support) or Windows 11
* Installed Docker (for Linux) or Docker Decktop (for Windows/WSL2)
* Intel ARC series GPU (tested with Intel ARC A770 16GB, Intel(R) Core(TM) Ultra 5 125H integrated GPU, and Intel(R) Core(TM) Ultra 7 258V integrated GPU)
* The NPU device uses a precompiled firmware blob that needs to be updated on the host outside of the docker environment.  The following steps will install the required firmware blob upon the next system reboot:
```
$ wget https://github.com/intel/linux-npu-driver/releases/download/v1.13.0/intel-fw-npu_1.13.0.20250131-13074932693_ubuntu24.04_amd64.deb
$ sudo dpkg -i *.deb
$ sudo reboot
```

## Docker 

These samples utilize containers to fully encapsulate the example with minimial host dependencies.  Here are the instructions how to install docker:

```
$ sudo apt-get update
$ sudo apt-get install ca-certificates curl
$ sudo install -m 0755 -d /etc/apt/keyrings
$ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
$ sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable docker access as user
sudo groupadd docker
sudo usermod -aG docker $USER
```
Note: This configuration above grants full root access of the container to your machine. Only follow this if you understand the implications for doing so, and don't follow this procedure on a production machine.

## Usage

To run benchmarks for CPU, GPU, and NPU using the resnet50 model:
```
$ sudo apt install make
$ make
```

## WSL
The scripts above are supported with Docker Desktop and Windows WSL for CPU and GPU.  NPU is not currently available in Microsoft WSL subsystem.

## Multiple GPU
The scripts above will search for and select the GPU with the largest number of execution units.  If more than one GPU is present and they share the same number of execution units, the scripts will use both of them together using OpenVINO's MULTI device support.

## References
* https://docs.openvino.ai/2024/get-started/configurations/configurations-intel-gpu.html
* https://docs.openvino.ai/2024/get-started/configurations/configurations-intel-npu.html

## Notes
* Kernel 6.8.0-38-generic may cause a ARC GPU hang. See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2072755. Use Kernel 6.8.0-36-generic or older, or latest kernel
* Intel(R) Core(TM) Ultra 7 258V GPU is not currently detected with 6.8 series kernel for compute runtime.
