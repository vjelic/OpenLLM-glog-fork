#!/bin/bash

# fail at first error
set -e

# Script to run OpenLLM server with Mistral model
# to be run inside OpenLLM docker container
# assuming the container is already running

# Set the GPUs to be used
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
# To suppress errors when rocBlas spawns too many threads
export OMP_NUM_THREADS=8

# Start OpenLLM server with Mistral model
# choice:
#   mistralai/Mistral-7B-Instruct-v0.1
#   meta-llama/Llama-2-7b-chat-hf
MODEL_NAME=mistralai/Mistral-7B-Instruct-v0.1

# choice:  pt, vllm, ctranslate, triton
BACKEND=vllm
MAX_NEW_TOKENS=200
TEMPERATURE=0.8
API_WORKERS=1
# fractional number will introduce multi-GPU: 0.5==2 GPUs, 0.25==4 GPUs, 0.125==8 GPUs
WORKERS_PER_RESOURCE=1
SERIALIZER=safetensors
# output log file to the mounted directory
OUTPUT_MOUNT=/myhome/openllm_server.log

openllm start ${MODEL_NAME} \
  --backend ${BACKEND} \
  --max-new-tokens ${MAX_NEW_TOKENS} \
  --temperature ${TEMPERATURE} \
  --api-workers ${API_WORKERS} \
  --workers-per-resource ${WORKERS_PER_RESOURCE} \
  --serialization ${SERIALIZER} \
  | tee ${OUTPUT_MOUNT}

# Once server is running, you can access it at http://localhost:43000
#   with 43000 being the port number mapped to the container's 3000 port
#   in the podman run command
