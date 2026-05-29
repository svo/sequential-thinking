#!/usr/bin/env bash

image=$1 &&
architecture=$2 &&

if [ -z "$architecture" ]; then
  docker push "svanosselaer/sequential-thinking-${image}" --all-tags
else
  docker push "svanosselaer/sequential-thinking-${image}:${architecture}"
fi
