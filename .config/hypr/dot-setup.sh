#!/bin/bash

# --- MY DEPENDENCIES ---
PACKAGES=(
    # System & Autostart
    "polkit-kde-agent" "kservice" "network-manager-applet"
    
    # programs.lua
    "kitty" "dolphin" "blueman" "pavucontrol" "copyq" 
    "wl-clip-persist" "hyprlock" "playerctl" "flameshot" 
    "cliphist" "mpg341" "ydotool" "smile" "xarchiver" 
    "loupe" "quickshell" "noctalia-shell"
    
    # env.lua
    "qt6ct" "gcr" "xdg-desktop-portal-gtk" "xdg-desktop-portal-hyprland"
)

echo "=== Installing dependencies for Hyprland ==="

# Use paru if available, otherwise yay, fallback to pacman
if command -v paru >/dev/null 2>&1; then
    INSTALLER="paru -S --noconfirm"
elif command -v yay >/dev/null 2>&1; then
    INSTALLER="yay -S --noconfirm"
else
    INSTALLER="sudo pacman -S --noconfirm"
fi

for pkg in "${PACKAGES[@]}"; do
    # Check if the package is already installed
    if ! pacman -Qs "$pkg" > /dev/null; then
        echo "[+] Installing $pkg..."
        $INSTALLER "$pkg"
    else
        echo "[=] $pkg is already installed."
    fi
done

# Setup configuration directories
mkdir -p "$HOME/.config/hypr/modules"

# Copy configuration files
echo "--- Copying configuration files ---"
cp -f "hyprland.lua" "$HOME/.config/hypr/"
cp -f modules/*.lua "$HOME/.config/hypr/modules/"

echo "=== Installation complete! ==="
echo "Your configuration is now ready to be used."