#!/bin/bash
# Sync npm global packages to package.json

DEPS_DIR="$HOME/.dotfiles/dependencies"

echo "📦 Syncing npm global packages..."
npm list -g --depth=0 --json 2>/dev/null | jq '{
  name: "global-packages",
  version: "1.0.0",
  description: "Global npm packages",
  dependencies: (.dependencies | to_entries | map(select(.key != "npm")) | map({key: .key, value: "*"}) | from_entries)
}' > "$DEPS_DIR/package.json"

NPM_COUNT=$(jq -r '.dependencies | length' "$DEPS_DIR/package.json")
echo "✓ $NPM_COUNT npm packages synced to package.json"
