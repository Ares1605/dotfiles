#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
WOFI_CONFIG="$HOME/.config/wofi/wallpaper"
WOFI_STYLE="$HOME/.config/wofi/style-wallpaper.css"

# Function to safely kill wofi processes
kill_wofi() {
    pkill -f "wofi.*wallpaper" 2>/dev/null
    sleep 0.2  # Give processes time to terminate
}

# Function to check if required files/directories exist
check_dependencies() {
    if [[ ! -d "$WALLPAPER_DIR" ]]; then
        echo "Error: Wallpaper directory '$WALLPAPER_DIR' not found"
        exit 1
    fi
    
    if [[ ! -f "$WOFI_CONFIG" ]]; then
        echo "Warning: Wofi config '$WOFI_CONFIG' not found"
    fi
    
    if [[ ! -f "$WOFI_STYLE" ]]; then
        echo "Warning: Wofi style '$WOFI_STYLE' not found"
    fi
}

menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.webp" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) 2>/dev/null | awk '{print "img:"$0}'
}

select_wallpaper() {
    kill_wofi
    
    local wallpaper_list
    wallpaper_list=$(menu)
    
    if [[ -z "$wallpaper_list" ]]; then
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi
    
    echo "$wallpaper_list" | wofi -c "$WOFI_CONFIG" -s "$WOFI_STYLE" --prompt "Select Wallpaper:" -n
}

select_backend() {
    kill_wofi
    
    local backends="wal
colorthief
modern_colorthief
colorz
okthief
fast_colorthief
haishoku"
    
    echo "$backends" | wofi --lines=7 --show dmenu --prompt "Select Backend:" -n
}

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
    
    # Create backup before modifying
    cp "$config_file" "$config_file.bak"
    
    sed -i "s/col\.inactive_border = .*/col.inactive_border = $inactive_rgba/" "$config_file"
    sed -i "s/col\.active_border = .*/col.active_border = $active_rgba/" "$config_file"
}

main() {
    # Check dependencies first
    check_dependencies
    
    # Select wallpaper
    local choice
    choice=$(select_wallpaper)
    
    # Exit if no wallpaper selected
    if [[ -z "$choice" ]]; then
        echo "No wallpaper selected"
        exit 0
    fi
    
    # Select backend
    local backend
    backend=$(select_backend)
    
    # Exit if no backend selected
    if [[ -z "$backend" ]]; then
        echo "No backend selected"
        exit 0
    fi
    
    # Extract wallpaper path
    local selected_wallpaper=$(echo "$choice" | sed 's/^img://')
    
    # Verify wallpaper file exists
    if [[ ! -f "$selected_wallpaper" ]]; then
        echo "Error: Selected wallpaper file not found: $selected_wallpaper"
        exit 1
    fi
    
    echo "Setting wallpaper: $selected_wallpaper"
    echo "Using backend: $backend"
    
    # Set wallpaper with swww
    if ! swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5; then
        echo "Error: Failed to set wallpaper with swww"
        exit 1
    fi
    
    # Generate color scheme with wal
    if ! wal --backend "$backend" -i "$selected_wallpaper" -n; then
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
}

# Trap to cleanup on exit
trap 'kill_wofi' EXIT

main "$@"
