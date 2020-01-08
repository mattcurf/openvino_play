#!/bin/bash
docker build -t openvino .
docker run -it --rm openvino bash -c 'cd /opt/intel/openvino/deployment_tools/demo && ./demo_benchmark_app.sh -d CPU'
docker run -it --rm --device /dev/dri:/dev/dri openvino bash -c 'cd /opt/intel/openvino/deployment_tools/demo && ./demo_benchmark_app.sh -d GPU'
