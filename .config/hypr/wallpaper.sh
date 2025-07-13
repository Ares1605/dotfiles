#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
#I dont know what the fuck I am doing
menu() {
   find "${WALLPAPER_DIR}" -type f \( -iname "*.webp" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}
main() {
   # kill the old process first
   pkill -f "wofi -c /home/ares/.config/wofi/wallpaper -s /home/ares/.config/wofi/style-wallpaper.css --show dmenu --prompt Select Wallpaper: -n"
   choice=$(menu | wofi -c ~/.config/wofi/wallpaper -s ~/.config/wofi/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
   
   # Exit if no wallpaper selected
   [[ -z "$choice" ]] && exit 0
   
   # kill the old process first
   pkill -f "wofi -c /home/ares/.config/wofi/wallpaper -s /home/ares/.config/wofi/style-wallpaper.css --show dmenu --prompt Select Wallpaper: -n"
   backends="colorthief
wal
modern_colorthief
colorz
okthief
fast_colorthief
haishoku"
   backend=$(echo "$backends" | wofi --lines=7 --show dmenu --prompt "Select Backend:" -n)
   
   # Exit if no backend selected
   [[ -z "$backend" ]] && exit 0
   
   selected_wallpaper=$(echo "$choice" | sed 's/^img://')
   swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5
   wal --backend $backend -i "$selected_wallpaper" -n
   # swaync-client --reload-css
   cat ~/.cache/wal/colors-kitty.conf > ~/.config/kitty/current-theme.conf
   pywalfox update
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
   inactive_rgba=$(hex_to_rgba "$color0")
   active_rgba=$(hex_to_rgba "$color15")
   sed -i "s/col\.inactive_border = .*/col.inactive_border = $inactive_rgba/" ~/.config/hypr/wallpaper-hyprland-custom.conf
   sed -i "s/col\.active_border = .*/col.active_border = $active_rgba/" ~/.config/hypr/wallpaper-hyprland-custom.conf
}
main
