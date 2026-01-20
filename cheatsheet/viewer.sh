#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cheatsheets=$(for f in "$SCRIPT_DIR"/*.txt; do
  name="${f##*/}"
  printf '%s\n' "${name%.txt}"
done)

if [ "$cheatsheets" = "*" ]; then
  echo "No cheatsheets available"
  exit 0
fi

base_target=$(echo "$cheatsheets" | fzf --no-sort)
if [ $? -ne 0 ]; then
  exit 0
fi

less "$SCRIPT_DIR/$base_target.txt"
