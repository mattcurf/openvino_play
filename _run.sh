#!/bin/bash
source /root/miniforge3/bin/activate ov
source /opt/intel/openvino_2024.3.0/setupvars.sh

ARCH=$(uname -m)
if [ "$ARCH" = 'x86_64' ]; then
  ARCH=intel64
elif [ "$ARCH" = 'arm64' ]; then
  ARCH=aarch64
fi

# Run query
/root/openvino_cpp_samples_build/$ARCH/Release/hello_query_device

# Run benchmark
python ./download_resnet50.py

/root/openvino_cpp_samples_build/$ARCH/Release/benchmark_app -m /tmp/model/ir_model/resnet50_fp16.xml -d CPU -hint throughput -niter 1000

if [ "$HAS_GPU" == "1" ]; then
  GPU_DEVICE=$(python ./gpu_select.py)
  /root/openvino_cpp_samples_build/$ARCH/Release/benchmark_app -m /tmp/model/ir_model/resnet50_fp16.xml -d $GPU_DEVICE -hint throughput -niter 1000
fi

if [ "$HAS_NPU" == "1" ]; then
  /root/openvino_cpp_samples_build/$ARCH/Release/benchmark_app -m /tmp/model/ir_model/resnet50_fp16.xml -d NPU -hint throughput -niter 1000
fi
