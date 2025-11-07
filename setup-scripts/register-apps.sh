#!/bin/bash

for file in ../registered_apps/*.desktop; do
    [ -f "$file" ] || continue
    sudo cp -f "$file" /usr/share/applications/ 2>/dev/null
done
