#!/usr/bin/env bash

DOCKER_IMAGE_TAG="ros:ros-tutorials"
DOCKER_DOCKERFILE="lunar/tutorials/Dockerfile"

docker build \
	--tag ${DOCKER_IMAGE_TAG} \
	-f ${DOCKER_DOCKERFILE} \
	.
