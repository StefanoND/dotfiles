#!/bin/sh
# "Change keyboard layout in" "~/.config/hypr/hyprland.conf" " " \

yad --width=592 --height=620 \
--center \
--fixed \
--title="Keybindings" \
--no-buttons \
--list \
--column=Key: \
--column=Description: \
--column=Command: \
--timeout=60 \
--timeout-indicator=right \
"ESC" "close this app" "" \
"=" "modkey" "(set mod Mod4)" \
"+Shift+g" "Godot" "(flatpak run Godot)" \
"+enter" "Terminal" "(kitty)" \
"+d" "Application Menu" "(wofi)" \
"" "Full Launcher" "(nwg-drawer)" \
"+Shift+f" "Open Browser" "(Firedragon)" \
"+t" "Open Files" "(Dolphin)" \
"+q" "close focused app" "(kill)" \
"+v" "clipboard manager" "(cliphist)" \
"+r" "Resize windows" "(resize)" \
"Print" "screenshot" "(grimblast)" \
"+Shift+s" "screenshot" "(grimblast)" \
"+0" "power-menu" "(nwgbar)" \
"+Shift+c" "Change wallpaper" "(wpaperd)" \
"+f" "Fullscreen" "Toggles to full screen" \
"+Alt+f" "Fake fullscreen" "Behave full screen without full screen" \
"+Spacebar" "Tile/Float" "Toggle windows to tile/float" \
"+p" "Dwindle effect" "pseudo" \
"+Shift+p" "Dwindle effect" "toggle split" \
"+i" "Calamares" "Install Garuda Hyprland" \
"" "" "Window closes in 60 sec."\
