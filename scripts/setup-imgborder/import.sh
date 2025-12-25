#!/bin/bash

# Create the target directory if it doesn't exist
mkdir -p ~/.config/hypr

# Copy the 'assets' folder
if [ -d ./assets ]; then
    cp -r ./assets ~/.config/hypr/
    echo "assets copied to ~/.config/waybar/assets"
else
    echo "No 'assets' folder found in current directory"
fi