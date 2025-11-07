#!/bin/bash
# Sync all currently installed packages to dependencies files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Syncing all currently installed packages..."
echo ""

# Run individual sync scripts
"$SCRIPT_DIR/sync-pip.sh"
echo ""
"$SCRIPT_DIR/sync-npm.sh"
echo ""
"$SCRIPT_DIR/sync-go.sh"

echo ""
echo "✅ All packages synced to ~/.dotfiles/dependencies/"
