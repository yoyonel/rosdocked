#!/usr/bin/env bash

docker exec \
	-it \
	master \
	bash -c "source /ros_entrypoint.sh && rostopic list"