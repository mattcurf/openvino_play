#!/bin/bash
source /opt/intel/openvino_2024.3.0/setupvars.sh

ARCH=$(uname -i)
if [ "$ARCH" == 'x86_64' ];
then 
  ARCH=intel64
fi

# Run query
/root/openvino_cpp_samples_build/$ARCH/Release/hello_query_device

# Run benchmark
python3 ./download_resnet50.py

/root/openvino_cpp_samples_build/$ARCH/Release/benchmark_app -m model/ir_model/resnet50_fp16.xml -d CPU -hint throughput -niter 1000

if [ "$HAS_GPU" == "1" ]; then
  /root/openvino_cpp_samples_build/$ARCH/Release/benchmark_app -m model/ir_model/resnet50_fp16.xml -d GPU -hint throughput -niter 1000
fi

if [ "$HAS_NPU" == "1" ]; then
  /root/openvino_cpp_samples_build/$ARCH/Release/benchmark_app -m model/ir_model/resnet50_fp16.xml -d NPU -hint throughput -niter 1000
fi
