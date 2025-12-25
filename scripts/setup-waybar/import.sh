#!/bin/bash

# Create the target directory if it doesn't exist
mkdir -p ~/.config/waybar

# Copy the 'icons' folder
if [ -d ./icons ]; then
    cp -r ./icons ~/.config/waybar/
    echo "Icons copied to ~/.config/waybar/icons"
else
    echo "No 'icons' folder found in current directory"
fi

# Copy the 'transparent-icons' folder
if [ -d ./transparent-icons ]; then
    cp -r ./transparent-icons ~/.config/waybar/
    echo "Transparent icons copied to ~/.config/waybar/transparent-icons"
else
    echo "No 'transparent-icons' folder found in current directory"
fi

# Copy the 'transparent-icons' folder
if [ -d ./hotbar]; then
    cp -r ./hotbar ~/.config/waybar/
    echo "hotbar copied to ~/.config/waybar/hotbar"
else
    echo "No 'hotbar' folder found in current directory"
fi

# Copy the 'scripts' folder
if [ -d ./scripts ]; then
    cp -r ./scripts ~/.config/waybar/
    echo "Scripts copied to ~/.config/waybar/scripts"
else
    echo "No 'scripts' folder found in current directory"
fi
