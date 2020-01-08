#!/bin/bash
docker build -t openvino_src_x64 .
docker run -it --rm openvino bash -c 'cd /dldt/inference-engine/bin/intel64/Release && ./benchmark_app -i /root/openvino/deployment_tools/demo/car.png -m /root/openvino_models/ir/public/squeezenet1.1/FP16/squeezenet1.1.xml -pc -niter 1000 -d CPU'
docker run -it --rm --device /dev/dri:/dev/dri openvino bash -c 'cd /dldt/inference-engine/bin/intel64/Release && ./benchmark_app -i /root/openvino/deployment_tools/demo/car.png -m /root/openvino_models/ir/public/squeezenet1.1/FP16/squeezenet1.1.xml -pc -niter 1000 -d GPU'
