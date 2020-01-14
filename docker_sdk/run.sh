#!/bin/bash
docker build -t openvino .
docker run -it --rm openvino bash -c 'cd /opt/intel/openvino/deployment_tools/inference_engine/samples/build/intel64/Release && ./benchmark_app -i /opt/intel/openvino/deployment_tools/demo/car.png -m /root/ir/public/squeezenet1.1/FP16/squeezenet1.1.xml -pc -niter 1000 -d CPU'
docker run -it --rm --device /dev/dri:/dev/dri openvino bash -c 'cd /opt/intel/openvino/deployment_tools/inference_engine/samples/build/intel64/Release && ./benchmark_app -i /opt/intel/openvino/deployment_tools/demo/car.png -m /root/ir/public/squeezenet1.1/FP16/squeezenet1.1.xml -pc -niter 1000 -d GPU'
# docker run -it --rm --device /dev/video0:/dev/video0 --device /dev/dri:/dev/dri -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY openvino bash
