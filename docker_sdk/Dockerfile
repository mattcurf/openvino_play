# Use the intel-opencl image from ubuntu 18.04 in order to provide OpenCL NEO runtime for Intel Integrated Graphics OpenCL compute
#FROM ubuntu:18.04
FROM intelopencl/intel-opencl:ubuntu-18.04-ppa

# Install a few minimal prerequisites (the remaining dependencies will be installed below from the Open Vino SDK
RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      cpio \
      sudo \
      git \
      lsb-release \
      python3 \
      python3-pip \
      python3-setuptools \
      libenchant1c2a && \
    pip3 install wheel && \
    rm -rf /var/lib/apt/lists/*

# Install OpenVino from SDK, combile and build the samples, and add the sample videos require for running select demos
ARG DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/16057/l_openvino_toolkit_p_2019.3.376.tgz
ARG INSTALL_DIR=/opt/intel/openvino
ARG TEMP_DIR=/tmp/openvino_installer

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
    git clone https://github.com/intel-iot-devkit/sample-videos.git $INSTALL_DIR/deployment_tools/sample-videos && \
    echo "source $INSTALL_DIR/bin/setupvars.sh" >> /root/.bashrc

# Download and convert models for demos.  Each demo indicates which models it requires from the 'models.lst' files in each folder, so we'll
# use those lists rather than download all of the models 
RUN cd $INSTALL_DIR/deployment_tools/open_model_zoo/tools/downloader && \
    python3 ./downloader.py --name squeezenet1.1 -o /root/models && \
    python3 ./converter.py --name squeezenet1.1 --mo $INSTALL_DIR/deployment_tools/model_optimizer/mo.py -d /root/models && \
    for i in `find ../../demos -name models.lst`; do python3 ./downloader.py --list $i -o /root/models; done  && \
    for i in `ls /root/models/public/`; do python3 ./converter.py --name $i --mo $INSTALL_DIR/deployment_tools/model_optimizer/mo.py -d /root/models; done && \
    for i in `ls /root/models/intel/`; do python3 ./converter.py --name $i --mo $INSTALL_DIR/deployment_tools/model_optimizer/mo.py -d /root/models; done
