#!/bin/bash
# update all currently installed packages to dependencies files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Updating all currently installed packages..."
echo ""

# Run individual update scripts
"$SCRIPT_DIR/update-pip.sh"
echo ""
"$SCRIPT_DIR/update-npm.sh"
echo ""
"$SCRIPT_DIR/update-go.sh"
echo ""
"$SCRIPT_DIR/update-pkglist.sh"
echo ""

echo ""
echo "✅ All packages updated to $DOTFILES_PATH/dependencies/"

echo "Updating wallpapers"
echo ""

"$SCRIPT_DIR/update-wallpapers.sh"
echo ""

echo "✅ Updated wallpapers $DOTFILES_PATH/wallpapers/"
