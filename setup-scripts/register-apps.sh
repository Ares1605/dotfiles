#!/bin/bash
# register apps from registered_apps directory
for file in "$DOTFILES_PATH/registered_apps"/*.desktop; do
    [ -f "$file" ] || continue
    sudo ln -sf "$file" /usr/share/applications/
done

# unregister apps from unregistered_apps.txt
while read file; do
    global_path="/usr/share/applications/$file"
    local_path="/usr/local/share/applications/$file"
    hide_line="Hidden=true"
    if [ -f $global_path ] && ! grep -qx $hide_line $global_path; then
        echo $hide_line >> sudo $global_path
        sudo sh -c "echo '$hide_line' >> '$global_path'"
    fi
    if [ -f $local_path ] && ! grep -qx $hide_line $local_path; then
        sudo sh -c "echo '$hide_line' >> '$local_path'"
    fi
done < "$DOTFILES_PATH/unregistered_apps.txt"

# Rofi drun holds application cache
rm -rf ~/.cache/rofi-drun-desktop.cache

sudo update-desktop-database
