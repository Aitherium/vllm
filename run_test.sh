#!/bin/bash
set -e
echo "=== Installing vLLM from PR branch ==="
cd /workspace/vllm-patch
VLLM_USE_PRECOMPILED=1 pip install -e . 2>&1 | tail -5
pip install scipy -q 2>&1 | tail -1
echo "=== Starting vLLM with --kv-cache-dtype tq-t4nc ==="
python3 -m vllm.entrypoints.openai.api_server \
  --model Qwen/Qwen2.5-1.5B-Instruct \
  --kv-cache-dtype tq-t4nc \
  --gpu-memory-utilization 0.5 \
  --max-model-len 4096 \
  --dtype auto \
  --trust-remote-code
