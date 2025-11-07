#!/bin/bash
# Setup script to add delta config to gitconfig

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GITCONFIG="$HOME/.gitconfig"
DELTA_CONFIG="$SCRIPT_DIR/../.gitconfig-delta"

# Create .gitconfig if it doesn't exist
if [ ! -f "$GITCONFIG" ]; then
    touch "$GITCONFIG"
fi

# Check if the include directive already exists
if grep -q "path = $DELTA_CONFIG" "$GITCONFIG" 2>/dev/null; then
    echo "✓ Delta config already included in ~/.gitconfig"
else
    echo "Adding delta config include to ~/.gitconfig..."
    # Add to the beginning of the file
    echo -e "[include]\n    path = $DELTA_CONFIG\n\n$(cat $GITCONFIG)" > "$GITCONFIG"
    echo "✓ Delta config added successfully!"
fi
