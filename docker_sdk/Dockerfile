#FROM ubuntu:18.04
FROM intelopencl/intel-opencl:ubuntu-18.04-ppa

ARG DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/16057/l_openvino_toolkit_p_2019.3.376.tgz
ARG INSTALL_DIR=/opt/intel/openvino
ARG TEMP_DIR=/tmp/openvino_installer

RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      cpio \
      sudo \
      lsb-release \
      python3 \
      python3-pip \
      python3-setuptools \
      libenchant1c2a && \
    pip3 install wheel && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p $TEMP_DIR && cd $TEMP_DIR && \
    wget -c $DOWNLOAD_LINK && \
    tar xf l_openvino_toolkit*.tgz && \
    cd l_openvino_toolkit* && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh -s silent.cfg && \
    $INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh && \
    pip3 install -r $INSTALL_DIR/deployment_tools/open_model_zoo/tools/downloader/requirements.in && \
    pip3 install -r $INSTALL_DIR/deployment_tools/model_optimizer/requirements.txt && \
    pip3 install -r $INSTALL_DIR/deployment_tools/model_optimizer/requirements_caffe.txt && \
    pip3 install -r $INSTALL_DIR/deployment_tools/model_optimizer/requirements_tf.txt && \
    pip3 install m2r pyenchant pylint Sphinx safety test-generator && \
    mkdir $INSTALL_DIR/deployment_tools/inference_engine/samples/build && cd $INSTALL_DIR/deployment_tools/inference_engine/samples/build && \
    /bin/bash -c "source $INSTALL_DIR/bin/setupvars.sh && cmake .. && make --jobs=$(nproc --all)" && \
    mkdir $INSTALL_DIR/deployment_tools/open_model_zoo/demos/build && cd $INSTALL_DIR/deployment_tools/open_model_zoo/demos/build && \
    /bin/bash -c "source $INSTALL_DIR/bin/setupvars.sh && cmake .. && make --jobs=$(nproc --all)" && \
    rm -rf $TEMP_DIR && \
    echo "source $INSTALL_DIR/bin/setupvars.sh" >> /root/.bashrc

RUN cd $INSTALL_DIR/deployment_tools/open_model_zoo/tools/downloader && \
    for i in squeezenet1.1 face-detection-adas-0001 age-gender-recognition-retail-0013  head-pose-estimation-adas-0001 emotions-recognition-retail-0003 vehicle-license-plate-detection-barrier-0106 vehicle-attributes-recognition-barrier-0039 license-plate-recognition-barrier-0001; \
    do python3 ./downloader.py --name $i --output_dir /root/models --cache_dir /root/cache; \
       python3 ./converter.py --mo $INSTALL_DIR/deployment_tools/model_optimizer/mo.py --name $i -d /root/models -o /root/ir --precisions FP16; \
    done

