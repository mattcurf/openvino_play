# openvino_play

This repo demonstrates the setup of all required Intel GPU and NPU user-space drivers for use with OpenVINO 2024.3. It has been tested on a Intel 13th Gen Intel(R) Core(TM) i9-13900H,  Intel(R) Core(TM) Ultra 5 125H processor, and 13th Gen Intel(R) Core(TM) i7-13700K with Intel(R) ARC A770 Discrete GPU

## Prerequisite
* Ubuntu 24.04 with kernel 6.8.0-36-generic (for Intel GPU kernel driver support)
* Installed Docker (for Linux)
* Intel ARC series GPU (tested with Intel ARC A770 16GB and Intel(R) Core(TM) Ultra 5 125H integrated GPU)
* The NPU device uses a precompiled firmware blob that needs to be updated on the host outside of the docker environment.  The following steps will install the required firmware blob upon the next system reboot:
```
$ wget https://github.com/intel/linux-npu-driver/releases/download/v1.6.0/intel-fw-npu_1.6.0.20240814-10390978568_ubuntu24.04_amd64.deb
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

## Usage

To build the containers, type:
```
$ ./build
```

To execute the 'hello_query_device' app to print information about CPU, GPU, and NPU devices, then run benchmarks for CPU, GPU, and NPU using the resnet50 model:
```
$ ./run
```

## References
* https://docs.openvino.ai/2024/get-started/configurations/configurations-intel-gpu.html
* https://docs.openvino.ai/2024/get-started/configurations/configurations-intel-npu.html

## Notes
* Kernel 6.8.0-38-generic and later may cause a ARC GPU hang. See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2072755. Use Kernel 6.8.0-36-generic or older
