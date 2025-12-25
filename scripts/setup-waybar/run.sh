#!/bin/bash
set -e

# ---------- 1. Install Waybar ----------
echo "Installing Waybar..."
sudo pacman -Syu --noconfirm waybar

# Optional: install fonts for Minecraft-style icons
echo "Installing fonts..."
sudo pacman -S --noconfirm noto-fonts-emoji ttf-nerd-fonts-symbols

# ---------- 1a. Install ydotool ----------
echo "Installing ydotool..."
sudo pacman -S --noconfirm ydotool

# ---------- 2. Create config folders ----------
CONFIG_DIR="$HOME/.config/waybar"
mkdir -p "$CONFIG_DIR"

# ---------- 3. Write basic Minecraft-themed config ----------
cat > "$CONFIG_DIR/config" << 'EOF'
* {
    "layer": "top",
    "position": "bottom",
    "height": 45,
    "margin-bottom": 10,
    "spacing": 0,

    // --- LEFT BAR ---
    "modules-left": [
        "hyprland/window",
        "cpu",
        "memory",
        "custom/gpu",
        "mpris"
    ],

    // --- CENTER BAR (The Inventory) ---
    "modules-center": [
        "hyprland/workspaces"
    ],

    // --- RIGHT BAR ---
    "modules-right": [
        "custom/record",
        "custom/snip",
        "custom/notifications",
        "clock"
    ],

    // --- MODULE CONFIGS ---

    "hyprland/workspaces": {
        "format": " ", // Empty so we see the icon only
        "persistent-workspaces": { "*": 9 }
    },

    "hyprland/window": {
        "format": "{title}",
        "max-length": 25,
        "separate-outputs": true
    },

    "cpu": { "format": "CPU {usage}%", "interval": 2 },
    "memory": { "format": "RAM {percentage}%", "interval": 2 },

    "custom/gpu": {
    "exec": "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits",
    "format": "GPU {}%",
    "interval": 2
    },

    "mpris": { "format": "♪ {title}", "max-length": 15 },

    "clock": {
        "format": "{:%H:%M}",
        "tooltip-format": "{:%Y-%m-%d}"
    },

    "custom/record": { "format": "REC", "on-click": "exec wf-recorder" },
    "custom/snip": { "format": "SNIP", "on-click": "grim -g \"$(slurp)\" - | wl-copy" },
    "custom/notifications": {
        "format": "NOTIF",
        "on-click": "./.config/waybar/scripts/toggle-sidebar.sh"
    }
}
EOF

cat > "$CONFIG_DIR/style.css" << 'EOF'
/* ==============================================================================
 *   MINECRAFT THEME - TEXTURE PACK EDITION
 * ============================================================================== */

/* --- 1. GLOBAL RESET --- */
* {
    border: none;
    border-radius: 0;
    font-family: "Monocraft", "Minecraftia", "Minecraft", monospace;
    font-weight: bold;
    min-height: 0;
    margin: 0;
    padding: 0;
}

window#waybar {
    background: transparent;
}

/* --- 2. THE CONTAINER --- */
.modules-left, .modules-center, .modules-right {
    background: none;
    border: none;
    padding: 0;
    margin: 0px 10px;
}

/* --- 3. STANDARD BUTTONS (Left & Right Modules) --- */
#window, #cpu, #memory, #custom-gpu, #mpris,
#custom-record, #custom-snip, #custom-notifications, #clock {
font-size: 18px;
background-color: #C6C6C6;
color: #ffffff;
min-height: 32px;
margin: 0px 3px;
padding: 0px 10px;

/* 3D Bevels */
border-top: 3px solid #373737;
border-left: 3px solid #373737;
border-bottom: 3px solid #ffffff;
border-right: 3px solid #ffffff;

text-shadow: 2px 2px 0px #3f3f3f;
}

/* --- 4. THE INVENTORY (Workspaces) --- */
#workspaces button {
/* Square Shape */
min-width: 45px;
min-height: 45px;
padding: 0;
margin: 0px 2px;

/* Slot Appearance */
background-color: #8b8b8b; /* Darker slot color */

/* Icon Settings */
background-repeat: no-repeat;
background-position: center;
background-size: 100%; /* Adjusts how big the sword/pickaxe looks */

/* Slot Bevels (Inset look) */
border-bottom: 3px solid #ffffff;
border-right: 3px solid #ffffff;
border-top: 3px solid #373737;
border-left: 3px solid #373737;
}

/* The Active Slot (Selected Item) */
#workspaces button.active {
background-color: #8b8b8b;
border: 4px solid #ffffff; /* Thick white selection box */
box-shadow: none;
}

/* Hover State */
#workspaces button:hover {
background-color: #a0a0a0;
}

/* --- 5. ASSIGNING ICONS TO SLOTS --- */

/* Slot 1: Diamond Sword */
#workspaces button:nth-child(1) {
background-image: url("/home/aadam/.config/waybar/icons/diamond_sword.png");
}

/* Slot 2: Diamond Pickaxe */
#workspaces button:nth-child(2) {
background-image: url("/home/aadam/.config/waybar/icons/diamond_pickaxe.png");
}

/* Slot 3: Diamond Axe */
#workspaces button:nth-child(3) {
background-image: url("/home/aadam/.config/waybar/icons/diamond_axe.png");
}

/* Slot 4: Golden Apple */
#workspaces button:nth-child(4) {
background-image: url("/home/aadam/.config/waybar/icons/enchanted_golden_apple.png");
}

/* Slot 5: Mutton */
#workspaces button:nth-child(5) {
background-image: url("/home/aadam/.config/waybar/icons/cooked_mutton.png");
}

/* Slot 6: Redstone */
#workspaces button:nth-child(6) {
/* Note: If redstone.png doesn't work, try redstone_dust.png */
background-image: url("/home/aadam/.config/waybar/icons/redstone.png");
}

/* Slot 7: Wheat Seeds */
#workspaces button:nth-child(7) {
background-image: url("/home/aadam/.config/waybar/icons/wheat_seeds.png");
}

/* Slot 8: Diamond */
#workspaces button:nth-child(8) {
background-image: url("/home/aadam/.config/waybar/icons/diamond.png");
}

/* Slot 9: Water Bucket */
#workspaces button:nth-child(9) {
background-image: url("/home/aadam/.config/waybar/icons/water_bucket.png");
}

/* --- 6. HOVER EFFECTS FOR MODULES --- */
#custom-record:hover,
#custom-snip:hover,
#custom-notifications:hover {
background-color: #D9D9D9;
}

/* ==============================================================================
 *   RIGHT MODULES - ITEM ICONS (FIXED)
 * ============================================================================== */

/* Common settings for these three buttons */
#custom-record, #custom-snip, #custom-notifications {
/* 1. NUCLEAR OPTION: Shrink text to zero so it's impossible to see */
font-size: 0px;

/* 2. Remove the text shadow we added globally */
text-shadow: none;

/* 3. Make text transparent just in case */
color: transparent;

/* Center the icon */
background-repeat: no-repeat;
background-position: center;
background-size: 60%;
min-width: 45px;
}

/* 1. Record -> Spyglass */
#custom-record {
background-image: url("/home/aadam/.config/waybar/transparent-icons/spyglass.png");
}

/* 2. Snip -> Shears */
#custom-snip {
background-image: url("/home/aadam/.config/waybar/transparent-icons/shears.png");
}

/* 3. Notifications -> Bell */
#custom-notifications {
background-image: url("/home/aadam/.config/waybar/transparent-icons/bell.png");
}
EOF

# ---------- 3a. Run import script ----------
DIR="$(dirname "$0")"
"$DIR/import.sh"

# ---------- 4. Autostart Waybar ----------
AUTOSTART="$HOME/.config/hypr/hyprland.conf"

if ! grep -q "exec waybar" "$AUTOSTART"; then
    echo "Adding Waybar to Hyprland autostart..."
    echo "exec-once = waybar" >> "$AUTOSTART"
fi

echo "Waybar installed with basic Minecraft theme!"
echo "Icons and scripts copied, ydotool installed!"
echo "You can run Waybar now with 'waybar &'"
