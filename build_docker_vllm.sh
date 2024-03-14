#!/bin/bash

# fail at first error
set -e

# 0. clone OpenLLM source
# git clone https://github.com/ROCm/OpenLLM/tree/feature/create-plexus-app

# 1. clone vllm source
# 2. build vllm docker
# 3. from OpenLLM source, build OpenLLM docker
# Steps 1-3 are taken care of in DOCKER_FILE below

# ROCm 6.0, Ubuntu 20.04, Python 3.9, PyTorch 2.1.1
BUILD_VERSION=rocm6-ub20-py39-pt211
DOCKER_FILE=Dockerfile.rocm-vllm

# podman build needs disabling security label check
# when docker can be run as root, --security-opt option is not needed
podman build \
    --security-opt label=disable \
    -t ollm:${BUILD_VERSION} \
    -f ${DOCKER_FILE} .
