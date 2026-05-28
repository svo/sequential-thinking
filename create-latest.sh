#!/usr/bin/env bash

image=$1

docker manifest rm "svanosselaer/sequential-thinking-${image}:latest" 2>/dev/null || true

docker manifest create \
  "svanosselaer/sequential-thinking-${image}:latest" \
  --amend "svanosselaer/sequential-thinking-${image}:amd64" \
  --amend "svanosselaer/sequential-thinking-${image}:arm64" &&
docker manifest push "svanosselaer/sequential-thinking-${image}:latest"
