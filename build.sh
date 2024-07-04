#!/bin/bash
docker build -t openvino-base -f docker/Dockerfile docker
docker build -t openvino-gpu -f docker/Dockerfile.gpu docker 
docker build -t openvino-gpu-npu -f docker/Dockerfile.npu docker 

