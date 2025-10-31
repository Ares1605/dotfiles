#!/bin/bash
hyprctl dispatch exec "[float;size 250 100;center] \
kitty --class fast \
-e sh -c 'printf \"\033[?25l\"; fast --upload; exec sleep infinity'"
