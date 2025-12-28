#!/usr/bin/env bash

set -e

if pacman -Qi kate >/dev/null 2>&1; then
    echo "Kate is already installed."
else
    echo "==> Kate not found. Installing..."
    sudo pacman -S --needed --noconfirm kate
    echo "Kate installed successfully."
fi
