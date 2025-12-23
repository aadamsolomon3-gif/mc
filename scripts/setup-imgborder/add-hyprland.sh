#!/bin/bash

# ===============================
# Configure imgborders in Hyprland
# ===============================

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
BACKUP="$HOME/.config/hypr/hyprland.conf.bak"

echo "=== Configuring imgborders for Hyprland ==="

# 1. Check if config file exists
if [ ! -f "$HYPR_CONF" ]; then
    echo "Error: $HYPR_CONF not found. Please ensure Hyprland is installed and the config exists."
    exit 1
fi

# 2. Backup the config
if [ ! -f "$BACKUP" ]; then
    cp "$HYPR_CONF" "$BACKUP"
    echo "Backup created at $BACKUP"
else
    echo "Backup already exists at $BACKUP"
fi

# 3. Check if imgborders plugin is already configured
if grep -q "imgborders {" "$HYPR_CONF"; then
    echo "imgborders section already exists in $HYPR_CONF. Skipping..."
else
    echo "Adding imgborders configuration to $HYPR_CONF..."
    cat << 'EOF' >> "$HYPR_CONF"

# ===============================
# imgborders Plugin Configuration
# ===============================
exec-once = hyprctl plugin load $codeDir/build/imgborders.so
plugin {
        imgborders {
	        enabled = true
	        image = ~/.config/hypr/assets/imgborder/gui.png
	        sizes = 8, 8, 8, 8
	        insets = 0, 0, 0, 0
	        scale = 2
	        smooth = false
	        blur = false
        }
}
EOF
    echo "imgborders configuration added successfully."
fi

echo "Done. Your original config is backed up at $BACKUP."
