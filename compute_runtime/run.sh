#!/bin/bash

docker build -t compute-runtime .

docker run -it --rm --net=host --privileged --device /dev/dri:/dev/dri compute-runtime

