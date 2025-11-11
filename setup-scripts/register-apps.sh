#!/bin/bash
for file in "$DOTFILES_PATH/registered_apps"/*.desktop; do
    [ -f "$file" ] || continue
    sudo ln -sf "$file" /usr/share/applications/
done
