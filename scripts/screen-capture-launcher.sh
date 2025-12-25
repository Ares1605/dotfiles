#!/bin/bash

set -e

cd "$HOME/Documents/recordings/"
# If the user cancels the slurp selection, $(slurp) exit code will be 1,
# and the script will exit appropriately.
geometry=$(slurp) 
wf-recorder --audio --geometry "$geometry" -f "$(date +"%Y-%m-%d_%H:%M:%S").mp4"
