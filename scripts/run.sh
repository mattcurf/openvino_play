#!/bin/bash

# Download and export model
python /project/scripts/download_resnet50.py

benchmark_app -m /tmp/model/ir_model/resnet50_fp16.xml -d CPU -hint throughput -niter 1000

if [ "$HAS_GPU" == "1" ]; then
  GPU_DEVICE=$(python /project/scripts/gpu_select.py)
  benchmark_app -m /tmp/model/ir_model/resnet50_fp16.xml -d $GPU_DEVICE -hint throughput -niter 1000
fi

if [ "$HAS_NPU" == "1" ]; then
  benchmark_app -m /tmp/model/ir_model/resnet50_fp16.xml -d NPU -hint throughput -niter 1000
fi
