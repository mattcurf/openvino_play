#!/bin/bash

docker build -t openvino-base:2020.3 -f Dockerfile.base .
docker build -t openvino-demo:2020.3 -f Dockerfile.demos .
docker build -t openvino-streamer:2020.3 -f Dockerfile.streamer .

