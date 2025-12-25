#!/bin/bash

# ===============================
# Safe HyprPM Setup Script with Dependency Check
# ===============================

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

./import.sh

echo "=== HyprPM Setup Script ==="

# 1. Check if hyprpm is installed
if ! command_exists hyprpm; then
    echo "Error: hyprpm is not installed. Please install it first."
    exit 1
fi

# 2. Check and install missing dependencies
echo "Checking dependencies..."
DEPENDENCIES=(cmake meson cpio pkgconf git gcc g++)
MISSING=()

for dep in "${DEPENDENCIES[@]}"; do
    if ! command_exists "$dep"; then
        MISSING+=("$dep")
    fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo "Installing missing dependencies: ${MISSING[*]}"
    sudo pacman -S --needed "${MISSING[@]}" || { echo "Failed to install dependencies"; exit 1; }
else
    echo "All dependencies are already installed."
fi

# 3. Update hyprpm
echo "Updating HyprPM..."
if ! hyprpm update; then
    echo "Error: Failed to update HyprPM. Please check dependencies."
    exit 1
fi

# 4. Add repository
REPO_URL="https://codeberg.org/zacoons/imgborders"
REPO_NAME="imgborders"

if hyprpm list | grep -q "$REPO_NAME"; then
    echo "Repository '$REPO_NAME' is already added."
else
    echo "Adding repository '$REPO_NAME'..."
    if ! hyprpm add "$REPO_URL"; then
        echo "Error: Failed to add repository. Make sure 'hyprpm update' completed successfully."
        exit 1
    fi
fi

# 5. Enable repository
if hyprpm enabled | grep -q "$REPO_NAME"; then
    echo "Repository '$REPO_NAME' is already enabled."
else
    echo "Enabling repository '$REPO_NAME'..."
    if ! hyprpm enable "$REPO_NAME"; then
        echo "Error: Failed to enable repository."
        exit 1
    fi
fi

# 6. Add configuration to hyprland.config
if ! ./add-hyprland.sh; then
    echo "Error: add-hyprland.sh failed"
    exit 1
fi

echo "HyprPM setup completed successfully!"
