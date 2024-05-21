#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

cd "$HOME"

git clone https://github.com/Frogging-Family/linux-tkg.git
cd linux-tkg
# Optional: edit the "customization.cfg" file
makepkg -si
sync
sleep 1s

# cd ~
#
# git clone https://github.com/Frogging-Family/nvidia-all.git
# cd nvidia-all
# makepkg -si
# sync

exit 0
