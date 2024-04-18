#!/bin/bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

PKGS=(
    # Hyprland
    'swww'                        # Solution to your Wayland Wallpaper Woes
    'wlogout'                     # Logout
    'emote'                       # Emoji Picker
    'nwg-look'                    # Settings Editor

    # Terminal
    'pacseek'                     # Package Manager
    'fastfetch'                   # Package Manager

    # Misc
    # 'vscodium-bin'                # VS Code without Microsoft's branding/telemetry/licensing
    # 'vscodium-bin-marketplace'    # VS Codium market place
    # 'vscodium-bin-features'       # Unblock some features blocked for non-MS's VSCode
    'davinci-resolve'             # Video editing software
    'deckboard-appimage'          # Streamdeck alternative
    'hplip-plugin'                # Plugin for HP Deskjet (All-in-One) printers
    'mullvad-vpn'                 # VPN
    'expressvpn'                  # VPN
    'dxvk-bin'                    # Vulkan-based compatibility layer for Direct3D 9/10/11
    'vkd3d-proton-bin'            # Vulkan-based compatibility layer for Direct3D 12
    'ventoy-bin'                  # Multiboot USB Solution
)

for PKG in "${PKGS[@]}"; do
    echo
    echo "INSTALLING: ${PKG}"
    echo
    paru -S "$PKG" --noconfirm --needed --sudoloop
    echo
    sleep 1s
done

exit 0
