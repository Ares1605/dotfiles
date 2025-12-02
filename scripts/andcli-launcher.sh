#!/bin/bash
hyprctl dispatch exec "[float;size 650 350;center;move 550 50] \ 
kitty --class andcli \
--override font_size=10 \
-e sh -c 'printf \"\033[?25l\"; andcli -t keepass ~/vault.kdbx -c wl-copy; exec sleep infinity'"
