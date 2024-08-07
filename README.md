# openvino_play

This repo demonstrates the setup of all required Intel GPU and NPU user-space drivers for use with OpenVINO 2024.3. It has been tested on a Intel Intel(R) Core(TM) Ultra 5 125H processor and Ubuntu 24.04 

## Prerequisite

The NPU device uses a precompiled firmware blob that needs to be updated on the host outside of the docker environment.  The following steps will install the required firmware blob upon the next system reboot:
```
$ wget https://github.com/intel/linux-npu-driver/releases/download/v1.5.1/intel-fw-npu_1.5.1.20240708-9842236399_ubuntu22.04_amd64.deb
$ sudo dpkg -i *.deb
$ sudo reboot
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
