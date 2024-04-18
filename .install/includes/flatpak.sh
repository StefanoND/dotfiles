#!/bin/bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

PKGS=(
    'com.github.Matoking.protontricks'              # Wrapper to make winetricks work with Proton
    'com.github.micahflee.torbrowser-launcher'      # Tor Browser
    'com.github.tchx84.Flatseal'                    # Flatpak permission manager
    'com.heroicgameslauncher.hgl'                   # Epic Games and GOG launcher
    'com.obsproject.Studio'                         # Streaming software
    'com.spotify.Client'                            # Spotify
    'com.usebottles.bottles'                        # Bottles
    'com.valvesoftware.Steam'                       # Steam
    'fr.handbrake.ghb'                              # Transcoder
    'io.github.Qalculate.qalculate-qt'              # Calculator
    'io.github.achetagames.epic_asset_manager'      # Epic Games' Marketplace for Linux
    'io.github.antimicrox.antimicrox'               # Graphical program used to map gamepad keys to keyboard, mouse, scripts and macros
    'io.github.shiftey.Desktop'                     # Github Desktop app
    'io.mpv.Mpv'                                    # Media player
    'md.obsidian.Obsidian'                          # A knowledge base that works on local Markdown files
    'net.agalwood.Motrix'                           # Download Manager
    'net.davidotek.pupgui2'                         # ProtonUp-Qt
    'net.lutris.Lutris'                             # Lutris
    'net.mullvad.MullvadBrowser'                    # Mullvad Browser
    'nl.hjdskes.gcolor3'                            # Color Picker
    'org.blender.Blender'                           # 3D Modelling Software
    'org.gimp.GIMP'                                 # GNU Image Manipulator
    'org.inkscape.Inkscape'                         # Vector Graphics Editor
    'org.kde.kleopatra'                             # Certificate Manager and Unified Crypto GUI
    'org.kde.krita'                                 # Digital Painting Software
    'org.kde.okteta'                                # Hex Editor
    'org.mozilla.firefox'                           # Firefox Browser
    'org.onlyoffice.desktopeditors'                 # Open-source office suite ("replaces" MS Word, PowerPoint and Excel)
    'org.phoenicis.playonlinux'                     # "PlayOnLinux's Designated Successor"
    'org.qbittorrent.qBittorrent'                   # Torrent app
#    ''         #
)

for PKG in "${PKGS[@]}"; do
    echo
    echo "INSTALLING: ${PKG}"
    echo
    flatpak install --user flathub "$PKG" -y --or-update
    echo
    sleep 1s
done

exit 0
