#!/usr/bin/env bash

DOCKER_IMAGE_TAG="ros:ros-tutorials"

docker run -it --rm \
    --net foo \
    --name talker \
    --env ROS_HOSTNAME=talker \
    --env ROS_MASTER_URI=http://master:11311 \
    ${DOCKER_IMAGE_TAG} \
    rosrun roscpp_tutorials talker