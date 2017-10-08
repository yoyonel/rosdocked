#!/usr/bin/env bash

DOCKER_IMAGE_TAG="ros:ros-tutorials"

docker run -it --rm \
    --net foo \
    --name master \
    ${DOCKER_IMAGE_TAG} \
    roscore