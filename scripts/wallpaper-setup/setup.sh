#!/usr/bin/env bash

set -e

SRC="$PWD/Wallpapers"
DEST="$HOME/Pictures"

if [ ! -d "$SRC" ]; then
    echo "Error: 'Wallpapers' folder not found in this directory."
    exit 1
fi

echo "==> Ensuring destination exists: $DEST"
mkdir -p "$DEST"

echo "==> Copying Wallpapers → Pictures"
cp -r "$SRC" "$DEST"

echo "Wallpapers copied successfully."
