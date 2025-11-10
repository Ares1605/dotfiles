#!/bin/bash

set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

echo "=================================================="
echo "  Dotfiles Symlink Setup"
echo "=================================================="
echo ""
echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local description="$3"

    # Check if source exists
    if [ ! -e "$source" ]; then
        echo "⚠️  Skipping $description: source doesn't exist"
        return
    fi

    # Check if target already exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            local current_link=$(readlink "$target")
            if [ "$current_link" = "$source" ]; then
                echo "✓  $description: already linked correctly"
                return
            else
                echo "📦 Backing up existing symlink: $target"
                mkdir -p "$BACKUP_DIR"
                mv "$target" "$BACKUP_DIR/"
            fi
        else
            echo "📦 Backing up existing file/directory: $target"
            mkdir -p "$BACKUP_DIR"
            mv "$target" "$BACKUP_DIR/"
        fi
    fi

    # Create parent directory if needed
    local parent_dir=$(dirname "$target")
    if [ ! -d "$parent_dir" ]; then
        echo "📁 Creating directory: $parent_dir"
        mkdir -p "$parent_dir"
    fi

    # Create symlink
    ln -s "$source" "$target"
    echo "🔗 Linked: $description"
}

echo "Setting up symlinks..."
echo ""

# Root configuration files
echo "==> Root configuration files"
create_symlink "$DOTFILES_DIR/.myclirc" "$HOME/.myclirc" ".myclirc"
create_symlink "$DOTFILES_DIR/.wegorc" "$HOME/.wegorc" ".wegorc"
echo ""

# .config directories
echo "==> Configuration directories"
create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim" "nvim"
create_symlink "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty" "kitty"
create_symlink "$DOTFILES_DIR/.config/hypr" "$HOME/.config/hypr" "hypr"
create_symlink "$DOTFILES_DIR/.config/waybar" "$HOME/.config/waybar" "waybar"
create_symlink "$DOTFILES_DIR/.config/rofi" "$HOME/.config/rofi" "rofi"
create_symlink "$DOTFILES_DIR/.config/wal" "$HOME/.config/wal" "wal"
create_symlink "$DOTFILES_DIR/.config/ranger" "$HOME/.config/ranger" "ranger"
create_symlink "$DOTFILES_DIR/.config/lazysql" "$HOME/.config/lazysql" "lazysql"
create_symlink "$DOTFILES_DIR/.config/clock-rs" "$HOME/.config/clock-rs" "clock-rs"
create_symlink "$DOTFILES_DIR/.config/swayosd" "$HOME/.config/swayosd" "swayosd"
create_symlink "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml" "starship.toml"
create_symlink "$DOTFILES_DIR/.zsh" "$HOME/.zsh"
echo ""

# Scripts directory
echo "==> Scripts directory"
create_symlink "$DOTFILES_DIR/.scripts" "$HOME/.scripts" ".scripts"
echo ""

# Claude settings
echo "==> Claude settings"
create_symlink "$DOTFILES_DIR/.claude" "$HOME/.claude" ".claude"
echo ""

# Firefox chrome (optional - requires profile detection)
echo "==> Firefox customization (optional)"
FIREFOX_PROFILE_DIR=$(find "$HOME/.mozilla/firefox" -maxdepth 1 -name "*.default-release" 2>/dev/null | head -n 1)
if [ -n "$FIREFOX_PROFILE_DIR" ]; then
    create_symlink "$DOTFILES_DIR/firefox-chrome" "$FIREFOX_PROFILE_DIR/chrome" "firefox-chrome"
    create_symlink "$DOTFILES_DIR/firefox-user.js" "$FIREFOX_PROFILE_DIR/user.js" "firefox-user.js"
else
    echo "⚠️  Firefox profile not found. Skipping firefox-chrome."
    echo "   To manually link read the Firefox Troubleshooting section in the README.md"
fi
echo ""

# Summary
echo "=================================================="
echo "  Setup Complete!"
echo "=================================================="
echo ""

if [ -d "$BACKUP_DIR" ]; then
    echo "📦 Backups saved to: $BACKUP_DIR"
    echo ""
fi

echo "⚠️  Manual steps still needed:"
echo ""
echo "1. Zsh configuration:"
echo "   Add to your ~/.zshrc:"
echo "   source ~/.zsh/common.zsh"
echo ""
echo "2. Wego weather config (if using):"
echo "   cp $DOTFILES_DIR/.wegorc.template $DOTFILES_DIR/.wegorc"
echo "   Edit .wegorc and add your API key"
echo ""
echo "3. Git config:"
echo "   Run: ./setup-scripts/setup-gitconfig.sh"
echo ""
echo "4. Install dependencies:"
echo "   Run: ./setup-scripts/install-dependencies.sh"
echo ""
echo "5. Register applications:"
echo "   Run: sudo ./setup-scripts/register-apps.sh"
echo ""
echo "6. Add wallpapers:"
echo "   Run: ./setup-scripts/add-wallpapers.sh"
echo ""
