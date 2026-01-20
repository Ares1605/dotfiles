#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

add_cheatsheet_str="[ ADD CHEATSHEET ]"

cheatsheets=$(for f in "$SCRIPT_DIR"/*.txt; do
  name="${f##*/}"
  printf '%s\n' "${name%.txt}"
done)

if [ "$cheatsheets" = "*" ]; then
  fzf_input=$add_cheatsheet_str
else
  fzf_input=$(printf "%s\n%s" "$cheatsheets" "$add_cheatsheet_str")
fi

choice=$(echo "$fzf_input" | fzf --no-sort)
if [ $? -ne 0 ]; then
  exit 0
fi
if [ "$choice" = "$add_cheatsheet_str" ]; then
  read -p "Enter cheatsheet name: " name
  base_target="$name.txt"
else
  base_target="$choice"
fi

vim "$SCRIPT_DIR/$base_target.txt"
