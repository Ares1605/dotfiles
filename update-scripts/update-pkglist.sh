#!/bin/bash

# Update package lists for explicitly installed packages

# Get the dotfiles directory (parent of scripts directory)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEPENDENCIES_DIR="$DOTFILES_DIR/dependencies"

# Get explicitly installed AUR packages (foreign packages)
pacman -Qem | awk '{print $1}' > "$DEPENDENCIES_DIR/pkglist-aur.txt"

# Get explicitly installed repo packages (native packages)
pacman -Qen | awk '{print $1}' > "$DEPENDENCIES_DIR/pkglist-repo.txt"

echo "Package lists updated:"
echo "  - pkglist-aur.txt: $(wc -l < "$DEPENDENCIES_DIR/pkglist-aur.txt") packages"
echo "  - pkglist-repo.txt: $(wc -l < "$DEPENDENCIES_DIR/pkglist-repo.txt") packages"

