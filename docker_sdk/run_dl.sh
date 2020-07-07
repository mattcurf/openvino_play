#!/bin/bash

docker run -it --rm --device /dev/video0:/dev/video0 --device /dev/dri:/dev/dri -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`:/videos -e DISPLAY=$DISPLAY openvino_streamer 

