#!/bin/bash
# Sync pip packages to requirements.txt

DEPS_DIR="$HOME/.dotfiles/dependencies"

echo "📦 Syncing pip packages..."
pip list --format=freeze 2>/dev/null | grep -v "^-e " | sort > "$DEPS_DIR/requirements.txt"

PIP_COUNT=$(wc -l < "$DEPS_DIR/requirements.txt")
echo "✓ $PIP_COUNT pip packages synced to requirements.txt"
