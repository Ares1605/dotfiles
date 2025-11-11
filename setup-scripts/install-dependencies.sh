#!/bin/bash
set -e

DEPS_DIR="$DOTFILES_PATH/dependencies"

echo "🚀 Starting full system setup..."
echo ""

# Install system packages
if [ -f "$DEPS_DIR/pkglist-repo.txt" ]; then
    echo "Installing pacman packages..."
    sudo pacman -S --needed $(cat "$DEPS_DIR/pkglist-repo.txt" | tr '\n' ' ')
    echo "✓ Pacman packages installed"
fi

echo ""

if [ -f "$DEPS_DIR/pkglist-aur.txt" ]; then
    echo "Installing AUR packages..."
    yay -S --needed $(cat "$DEPS_DIR/pkglist-aur.txt" | tr '\n' ' ')
    echo "✓ AUR packages installed"
fi

echo ""

# Install language-specific packages
if [ -f "$DEPS_DIR/requirements.txt" ] && [ -s "$DEPS_DIR/requirements.txt" ]; then
    echo "Installing Python packages..."
    pip install --user -r "$DEPS_DIR/requirements.txt"
    echo "✓ Python packages installed"
fi

echo ""

if [ -f "$DEPS_DIR/package.json" ] && [ -s "$DEPS_DIR/package.json" ]; then
    echo "Installing Node packages..."
    npm install -g $(jq -r '.dependencies | keys[]' "$DEPS_DIR/package.json" | tr '\n' ' ')
    echo "✓ Node packages installed"
fi

echo ""

if [ -f "$DEPS_DIR/go-packages.txt" ] && [ -s "$DEPS_DIR/go-packages.txt" ]; then
    echo "Installing Go binaries..."
    while IFS= read -r pkg; do
        [ -z "$pkg" ] && continue
        go install "$pkg@latest"
    done < "$DEPS_DIR/go-packages.txt"
    echo "✓ Go binaries installed"
fi

echo ""
echo "✅ All packages installed!"
