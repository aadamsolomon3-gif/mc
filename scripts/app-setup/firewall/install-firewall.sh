#!/usr/bin/env bash

set -e

echo "==> Checking if UFW is installed..."
if pacman -Qi ufw >/dev/null 2>&1; then
    echo "UFW is already installed."
else
    echo "==> Installing UFW..."
    sudo pacman -S --needed --noconfirm ufw
    echo "UFW installed."
fi
