#!/bin/bash

docker build -t compute-runtime .
docker run -it --rm --device /dev/dri:/dev/dri compute-runtime bash -c "/tmp/level-zero-tests/out/ze_bandwidth"

