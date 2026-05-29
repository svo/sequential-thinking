#!/usr/bin/env bash

docker run --rm \
  -v "$(pwd)":/working-dir \
  -e NODE_AUTH_TOKEN \
  --entrypoint ./bin/publish \
  svanosselaer/sequential-thinking-builder:latest
