#!/usr/bin/env bash

# exit 0: Successful install
# exit 1: Can't "cd" to path

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

# Path you want to put your Unreal Engine Editor
# DON'T put a "/" at the start of the path
UEPATH=PATH/TO/UE/INSTALL

echo
echo "Installing Unreal Engine"
echo
cd /"$UEPATH" || exit 1

git clone https://aur.archlinux.org/unreal-engine.git
sed -i 's/export _WithDDC=.*/export _WithDDC=true/g' ./unreal-engine/PKGBUILD
sed -i "s/export _ue5_install_dir=.*/export _ue5_install_dir=\"$UEPATH/\${pkgname}\"/g" ./unreal-engine/PKGBUILD
sed -i 's/.*arch_auto=.*/arch_auto=true/g' ./unreal-engine/PKGBUILD

cd unreal-engine || exit 1
makepkg -si
