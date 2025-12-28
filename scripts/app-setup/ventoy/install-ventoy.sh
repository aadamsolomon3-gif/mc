#!/usr/bin/env bash

set -e

# Check if Ventoy is already installed
if command -v ventoy >/dev/null 2>&1; then
    echo "Ventoy is already installed."
    ventoy --version || true
    exit 0
fi

echo "==> Ventoy not found."

# Detect AUR helper
if command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
elif command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
else
    echo "No AUR helper found (yay or paru)."
    echo "Install one first, e.g.:"
    echo "  sudo pacman -S yay"
    exit 1
fi

echo "==> Using AUR helper: $AUR_HELPER"
echo "==> Installing ventoy-bin..."

$AUR_HELPER -S --needed ventoy-bin

echo
echo "Ventoy installed successfully."
echo "You can now run: ventoygui"
