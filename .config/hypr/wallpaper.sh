#!/bin/bash
#  ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗
#  ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
#  ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
#  ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
#  ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
#   ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
#
#  ██╗      █████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗███████╗██████╗
#  ██║     ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║██╔════╝██╔══██╗
#  ██║     ███████║██║   ██║██╔██╗ ██║██║     ███████║█████╗  ██████╔╝
#  ██║     ██╔══██║██║   ██║██║╚██╗██║██║     ██╔══██║██╔══╝  ██╔══██╗
#  ███████╗██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║███████╗██║  ██║
#  ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
#	originally written by: gh0stzk - https://github.com/gh0stzk/dotfiles
#	rewritten for hyprland by :	 develcooking - https://github.com/develcooking/hyprland-dotfiles
#	Info    - This script runs the rofi launcher, to select
#             the wallpapers included in the theme you are in.



# Set some variables
wall_dir="${HOME}/Pictures/wallpapers"
cacheDir="${HOME}/.cache/jp/${theme}"
rofi_command="rofi -x11 -dmenu -theme ${HOME}/.config/rofi/wall-select.rasi"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ] ; then
        mkdir -p "${cacheDir}"
    fi

hex_to_rgba() {
    local hex=${1#"#"}
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    echo "rgba($r,$g,$b,1)"
}
update_hyprland_colors() {
    local config_file="$HOME/.config/hypr/wallpaper-hyprland-custom.conf"

    if [[ ! -f "$config_file" ]]; then
        echo "Warning: Hyprland config file not found: $config_file"
        return 1
    fi

    # Source colors safely
    if [[ -f "$HOME/.cache/wal/colors.sh" ]]; then
        source "$HOME/.cache/wal/colors.sh"
    else
        echo "Warning: wal colors not found"
        return 1
    fi

    local inactive_rgba=$(hex_to_rgba "$color0")
    local active_rgba=$(hex_to_rgba "$color15")

    sed -i "s/col\.inactive_border = .*/col.inactive_border = $inactive_rgba/" "$config_file"
    sed -i "s/col\.active_border = .*/col.active_border = $active_rgba/" "$config_file"
}


physical_monitor_size=24
monitor_res=$(hyprctl monitors |grep -A2 Monitor |head -n 2 |awk '{print $1}' | grep -oE '^[0-9]+')
dotsperinch=$(echo "scale=2; $monitor_res / $physical_monitor_size" | bc | xargs printf "%.0f")
monitor_res=$(( $monitor_res * $physical_monitor_size / $dotsperinch ))

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
	if [ -f "$imagen" ]; then
		nombre_archivo=$(basename "$imagen")
			if [ ! -f "${cacheDir}/${nombre_archivo}" ] ; then
				magick "$imagen" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "${cacheDir}/${nombre_archivo}"
			fi
    fi
done

# Select a picture with rofi
wall_selection=$(find "${wall_dir}"  -maxdepth 1  -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A ; do  echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n" ; done | $rofi_command)

wall_path="${wall_dir}/${wall_selection}"

# Set the wallpaper
[[ -n "$wall_selection" ]] || exit 1
swww img "$wall_path" --transition-type any --transition-fps 60 --transition-duration .5

if ! wal --backend "wal" -i "$wall_path" -n; then
    echo "Error: Failed to generate colors with wal"
    exit 1
fi

# Update kitty theme
if [[ -f "$HOME/.cache/wal/colors-kitty.conf" ]]; then
    mkdir -p "$HOME/.config/kitty"
    cat "$HOME/.cache/wal/colors-kitty.conf" > "$HOME/.config/kitty/current-theme.conf"
fi

# Update pywalfox
if command -v pywalfox >/dev/null 2>&1; then
    pywalfox update
fi

# Update hyprland colors
update_hyprland_colors

echo "Wallpaper and theme updated successfully!"

exit 0
