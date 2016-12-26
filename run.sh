#!/usr/bin/env bash

# Check args
if [ "$#" -ne 1 ]; then
  echo "usage: ./run.sh IMAGE_NAME"
  return 1
fi

# Get this script's path
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

set -e

# url: https://gist.github.com/d11wtq/8699521
# docker run --volume $SSH_AUTH_SOCK:/ssh-agent --env SSH_AUTH_SOCK=/ssh-agent ubuntu ssh-add -l

# url: http://serverfault.com/questions/634883/why-cant-i-cd-to-a-directory-with-docker-run

# Run the container with shared X11
docker run\
  --net=host\
  -e SHELL\
  -e DISPLAY\
  -e DOCKER=1\
  -v "$HOME:$HOME:rw"\
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw"\
  -v $SSH_AUTH_SOCK:/ssh-agent \
  -e SSH_AUTH_SOCK=/ssh-agent \
  -w $PWD \
  -it $1 $SHELL \
  -c "alias ls='ls --color=auto'"
