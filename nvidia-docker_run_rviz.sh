#!/usr/bin/env bash

# http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration#Nvidia
xhost + 

nvidia-docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    ros:nvidia \
    bash -c "roscore & rosrun rviz rviz"

xhost -