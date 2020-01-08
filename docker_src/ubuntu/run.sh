#!/bin/bash
docker build -t openvino_src_x64 .

git clone https://github.com/opencv/dldt /tmp/dldt
pushd /tmp/dldt
git submodule init
git submodule update
popd

# Build default version of openvino runtime
docker run -it --rm -v /tmp/dldt:/dldt openvino_src_x64 bash -c 'cd /dldt/inference-engine && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. &&   make --jobs=$(nproc --all)' 
