#!/bin/bash
set -e

# ---------- 1. Install Waybar ----------
echo "Installing Waybar..."
sudo pacman -Syu --noconfirm waybar

# Optional: install fonts for Minecraft-style icons
echo "Installing fonts..."
sudo pacman -S --noconfirm noto-fonts-emoji ttf-nerd-fonts-symbols

# ---------- 2. Create config folders ----------
CONFIG_DIR="$HOME/.config/waybar"
mkdir -p "$CONFIG_DIR"

# ---------- 3. Write basic Minecraft-themed config ----------
cat > "$CONFIG_DIR/config" << 'EOF'
{
    "layer": "top",
    "position": "top",
    "modules-left": ["sway/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "battery"],

    "font": "Noto Sans 10",
    "background": "#1e1e1e",
    "border": "2px solid #8b4513",
    "spacing": 2,
    "height": 30,
    "tray-position": "right",
    "colors": {
        "background": "#1e1e1e",
        "foreground": "#d4af37",
        "focused": "#00ff00",
        "urgent": "#ff0000",
        "separator": "#8b4513"
    }
}
EOF

cat > "$CONFIG_DIR/style.css" << 'EOF'
* {
font-family: monospace;
font-size: 12px;
}

#clock {
color: #00ff00;
font-weight: bold;
}

#pulseaudio,
#network,
#battery {
color: #d4af37;
}
EOF

# ---------- 4. Autostart Waybar ----------
AUTOSTART="$HOME/.config/hypr/hyprland.conf"

if ! grep -q "exec waybar" "$AUTOSTART"; then
    echo "Adding Waybar to Hyprland autostart..."
    echo "exec-once = waybar" >> "$AUTOSTART"
fi

echo "Waybar installed with basic Minecraft theme! You can run it now with 'waybar &'"
