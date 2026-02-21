#!/bin/bash

set -e

target=$1
if [[ -z $target ]]; then
  # Default to local README.md file
  target="README.md"
fi

free_port=$(ss -Htan | awk "{print $4}" | sed "s/.*://" | sort -n | comm -23 <(seq 1024 65535) - | head -n1)
grip --quiet --wide $target localhost:$free_port > /dev/null &
grip_pid=$!

awrit http://localhost:$free_port

kill $grip_pid
