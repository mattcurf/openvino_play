#!/bin/bash
docker build -t openvino .

# Benchmark, using CPU
docker run -it --rm openvino bash -c 'cd /opt/intel/openvino/deployment_tools/inference_engine/samples/build/intel64/Release && ./benchmark_app -i /opt/intel/openvino/deployment_tools/demo/car.png -m /root/ir/public/squeezenet1.1/FP16/squeezenet1.1.xml -pc -niter 1000 -d CPU'

# Benchmark, using GPU
docker run -it --rm --device /dev/dri:/dev/dri openvino bash -c 'cd /opt/intel/openvino/deployment_tools/inference_engine/samples/build/intel64/Release && ./benchmark_app -i /opt/intel/openvino/deployment_tools/demo/car.png -m /root/ir/public/squeezenet1.1/FP16/squeezenet1.1.xml -pc -niter 1000 -d GPU'

# Interactive Face Detection Demo, using GPU and USB camera
docker run -it --rm --device /dev/video0:/dev/video0 --device /dev/dri:/dev/dri -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY openvino bash -c 'source /opt/intel/openvino/bin/setupvars.sh&& cd /opt/intel/openvino/deployment_tools/open_model_zoo/demos/build/intel64/Release && ./interactive_face_detection_demo -i cam -m /root/models/intel/face-detection-adas-0001/FP16/face-detection-adas-0001.xml -d GPU'

# Security Barrier Camera Demo
docker run -it --rm --device /dev/video0:/dev/video0 --device /dev/dri:/dev/dri -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY openvino bash -c 'cd /opt/intel/openvino/deployment_tools/open_model_zoo/demos/build/intel64/Release && ./security_barrier_camera_demo -i /dev/video0 -m /root/models/intel/vehicle-license-plate-detection-barrier-0106/FP16/vehicle-license-plate-detection-barrier-0106.xml -m_va /root/models/intel/vehicle-attributes-recognition-barrier-0039/FP16/vehicle-attributes-recognition-barrier-0039.xml -m_lpr /root/models/intel/license-plate-recognition-barrier-0001/FP16/license-plate-recognition-barrier-0001.xml -d GPU'

