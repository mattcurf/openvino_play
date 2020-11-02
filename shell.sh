#/bin/bash

docker run -it --rm --privileged --net=host -e DISPLAY=$DISPLAY -v $HOME:/home openvino-apt 


