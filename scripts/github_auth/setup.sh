#!/usr/bin/env bash

set -e

# Install git if missing
if ! command -v git >/dev/null 2>&1; then
    echo "==> Installing git..."
    sudo pacman -S --needed --noconfirm git
fi

echo
read -rp "Enter your Git name: " GIT_NAME
read -rp "Enter your Git email: " GIT_EMAIL

echo
echo "==> Setting global Git configuration..."

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Optional sane defaults
git config --global init.defaultBranch main
git config --global pull.rebase false

echo
echo "==> Current Git config:"
git config --global --list

echo
echo "Git is now configured system-wide."
