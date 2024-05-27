#!/bin/bash
docker build -t intel-gpu-npu-driver docker 
docker build -t intel-gpu-npu-openvino -f docker/Dockerfile.openvino docker

