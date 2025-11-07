#!/bin/bash
# Make all .sh files in dotfiles directory executable

DOTFILES_DIR="$HOME/.dotfiles"

echo "Making all .sh files executable in $DOTFILES_DIR..."

find "$DOTFILES_DIR" -type f -name "*.sh" -exec chmod +x {} \;

echo "✓ All .sh files are now executable"
