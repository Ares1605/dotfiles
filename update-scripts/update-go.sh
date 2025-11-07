#!/bin/bash
# Sync Go binaries to go-packages.txt

DEPS_DIR="$HOME/.dotfiles/dependencies"

echo "📦 Syncing Go binaries..."
if [ -d "$HOME/go/bin" ]; then
    ls "$HOME/go/bin" | sort > "$DEPS_DIR/go-packages.txt"
    GO_COUNT=$(wc -l < "$DEPS_DIR/go-packages.txt")
    echo "✓ $GO_COUNT Go binaries synced to go-packages.txt"
else
    echo "⚠ No Go binaries found (~/go/bin doesn't exist)"
fi
