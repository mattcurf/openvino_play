#!/bin/bash
source /opt/intel/openvino_2024.1.0/setupvars.sh
/opt/intel/openvino_2024.1.0/samples/cpp/build_samples.sh
/root/openvino_cpp_samples_build/intel64/Release/hello_query_device
