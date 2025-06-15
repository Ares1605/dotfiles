#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
#I dont know what the fuck I am doing
menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}
main() {
    choice=$(menu | wofi -c ~/.config/wofi/wallpaper -s ~/.config/wofi/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')
    swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5
    wal -i "$selected_wallpaper" -n
    swaync-client --reload-css
    cat ~/.cache/wal/colors-kitty.conf > ~/.config/kitty/current-theme.conf
    # pywalfox update
    # cava_config="$HOME/.config/cava/config"
    # pkill -USR2 cava 2>/dev/null
    source ~/.cache/wal/colors.sh

    # manipulate the wallpaper-hyprland-custom.conf file
    # to change specific hyprland properties
    hex_to_rgba() {
        hex=${1#"#"}
        r=$((16#${hex:0:2}))
        g=$((16#${hex:2:2}))
        b=$((16#${hex:4:2}))
        echo "rgba($r,$g,$b,1)"
    }

    active_rgba=$(hex_to_rgba "$color2")
    sed -i "s/col\.active_border = .*/col.active_border = $active_rgba/" wallpaper-hyprland-custom.conf
}
main

