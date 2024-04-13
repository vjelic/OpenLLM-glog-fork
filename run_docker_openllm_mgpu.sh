#!/bin/bash

# fail at first error
set -e

BUILD_VERSION=rocm6-ub20-py39-pt211
JOB_NAME=ollm-test-mgpu
CONTAINER_NAME=ollm:${BUILD_VERSION}

podman run -it \
  --device=/dev/kfd --device=/dev/dri --group-add video \
  --security-opt seccomp=unconfined --security-opt label=disable \
  --name ${JOB_NAME} \
  -v $HOME:/myhome \
  -p 53000:3000 ${CONTAINER_NAME} \
  /bin/bash
