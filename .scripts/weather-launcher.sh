#!/bin/bash
hyprctl dispatch exec "[float;size 835 560;top] \
kitty --class weather \
--override font_size=8 \
-e sh -c 'printf \"\033[?25l\"; wego; exec sleep infinity'"
