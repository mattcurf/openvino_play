FROM ubuntu:16.04

USER root

# OpenVino Inference Engine 
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
       git \
       apt-utils \
       ca-certificates \
       sudo && \
    git clone https://github.com/opencv/dldt /dldt && \
    cd /dldt && \
    git submodule init && \
    git submodule update && \
    bash /dldt/inference-engine/install_dependencies.sh && \
    cd /dldt/inference-engine && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make --jobs=$(nproc --all)

# OpenVino Model Zoo & Model Optimizer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
       python3 \
       python3-pip \
       python3-setuptools \
       libenchant1c2a && \
    git clone http://github.com/opencv/open_model_zoo /open_model_zoo && \
    pip3 install wheel && \
    pip3 install -r /open_model_zoo/tools/downloader/requirements.in && \
    pip3 install -r /dldt/model-optimizer/requirements.txt && \
    pip3 install -r /dldt/model-optimizer/requirements_caffe.txt && \
    pip3 install -r /dldt/model-optimizer/requirements_tf.txt && \
    pip3 install m2r pyenchant pylint Sphinx safety test-generator

# Download and generate OpenVino model from model zoo
RUN cd /open_model_zoo/tools/downloader && \
    python3 ./downloader.py --name squeezenet1.1 --output_dir /root/openvino_models/models --cache_dir /root//openvino_models/cache && \
    python3 ./converter.py --mo /dldt/model-optimizer/mo.py --name squeezenet1.1 -d /root/openvino_models/models -o /root//openvino_models/ir --precisions FP16
