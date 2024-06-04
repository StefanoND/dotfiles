#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

if [ -d "$HOME"/.config/frogminer ]; then
  mv "$HOME"/.config/frogminer "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/frogminer "$HOME"/.config/

sudo pacman -S modprobed-db cronie --noconfirm --needed

modprobed-db

sed -i 's/nvidia nvidia_drm nvidia_modeset nvidia_uvm //g' "$HOME"/.config/modprobed-db.conf

modprobed-db store

cd "$HOME"


git clone https://github.com/Frogging-Family/linux-tkg.git
git clone https://github.com/Frogging-Family/nvidia-all.git
cd "$HOME"/linux-tkg
# Optional: edit the "customization.cfg" file
makepkg -si
sync
sleep 1s

cd "$HOME"/nvidia-all
sed -i 's/_dkms=""/_dkms="true"/g' customization.cfg
makepkg -si
sync

echo
echo "Run crontab -e and place the following in there:"
echo '0 */1 * * *   /usr/bin/modprobed-db store &> /dev/null'
echo

echo
echo "Done..."
echo
sleep 1s
echo
echo "Press Y to reboot now or N if you plan to manually reboot later."
echo
read REBOOT
if [ "${REBOOT,,}" = y ]; then
    reboot
fi

exit 0
