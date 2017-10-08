#!/usr/bin/env bash

DOCKER_IMAGE_TAG="ros_nvidia:lunar-desktop-full"
DOCKER_DOCKERFILE="lunar/nvidia/Dockerfile"

docker build \
	-t ${DOCKER_IMAGE_TAG} \
	-f ${DOCKER_DOCKERFILE} \
	.
