#!/usr/bin/env bash
set -e

# Detect the folder this script is in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -d "$SCRIPT_DIR" ]]; then
    echo "Error: $SCRIPT_DIR does not exist."
    exit 1
fi

# Make all scripts in the folder executable
echo "Making all scripts executable..."
chmod +x "$SCRIPT_DIR"/*

# Fish config file
FISH_CONFIG="$HOME/.config/fish/config.fish"

# Ensure config.fish exists
mkdir -p "$(dirname "$FISH_CONFIG")"
touch "$FISH_CONFIG"

# Check if folder is already in Fish PATH
if ! grep -q "$SCRIPT_DIR" "$FISH_CONFIG"; then
    echo "Adding $SCRIPT_DIR to Fish PATH..."
    echo "" >> "$FISH_CONFIG"
    echo "# Added by interactive-scripts setup" >> "$FISH_CONFIG"
    echo "set -gx PATH $SCRIPT_DIR \$PATH" >> "$FISH_CONFIG"
    echo "Folder added to Fish PATH permanently."
else
    echo "$SCRIPT_DIR is already in Fish PATH."
fi

echo "All scripts in $SCRIPT_DIR are now executable and ready to use."
echo "Open a new Fish shell or run: source ~/.config/fish/config.fish"
