#!/bin/bash

# The importance of an optimized mirror list can be found here:
#  https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Download_speeds
#  https://wiki.archlinux.org/title/Mirrors
# Reflector examples:
#  https://man.archlinux.org/man/reflector.1#EXAMPLES
#
#  This script (as describes in the examples link) will overwrite your mirrorlist
#  with the 5 best rate mirrors by download speed.

# Create backup of mirror list first
utc_date=$(date -u +%FT%H:%M:%SZ)

mirror_backups_dir="$HOME/Documents/mirror_backups"
mirror_backup_dir="$mirror_backups_dir/mirrorlist-$utc_date.bak"
mkdir -p $mirror_backups_dir
if cp /etc/pacman.d/mirrorlist $mirror_backup_dir; then
    echo "Backup created: $mirror_backup_dir"
else
    echo "Backup failed, stopping script execution. Mirrorlist was not successfully optimized" >&2
    exit 1
fi

# Now overwrite the mirrorlist with optimized mirrors
sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
