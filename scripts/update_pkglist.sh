#!/usr/bin/env bash

# Update package lists for explicitly installed packages

# Get the dotfiles directory (parent of scripts directory)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Get explicitly installed AUR packages (foreign packages)
pacman -Qem | awk '{print $1}' > "$DOTFILES_DIR/pkglist_aur.txt"

# Get explicitly installed repo packages (native packages)
pacman -Qen | awk '{print $1}' > "$DOTFILES_DIR/pkglist_repo.txt"

echo "Package lists updated:"
echo "  - pkglist_aur.txt: $(wc -l < "$DOTFILES_DIR/pkglist_aur.txt") packages"
echo "  - pkglist_repo.txt: $(wc -l < "$DOTFILES_DIR/pkglist_repo.txt") packages"
