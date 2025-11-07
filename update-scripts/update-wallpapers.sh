#!/bin/bash
# Copy wallpapers from ~/Pictures/wallpapers to dotfiles/wallpapers
cd $HOME/Pictures/wallpapers/
cp -f *.jpg *.png *.webp $HOME/.dotfiles/wallpapers/ 2>/dev/null
