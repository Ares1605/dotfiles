#!/bin/bash
hyprctl dispatch exec "[float;size 650 350;move 1220 50] \
kitty --class andcli --start-as normal \
--override remember_window_size=no \
--override font_size=10 \
-e sh -c 'printf \"\033[?25l\"; andcli -t keepass ~/vault.kdbx -c wl-copy; exec sleep infinity'"
