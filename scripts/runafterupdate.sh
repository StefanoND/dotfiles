sudo nvidia-modprobe

sudo systemctl enable --now nvidia-resume

sudo usermod -aG brlapi "$(logname)"

sudo systemctl enable --now expressvpn

sudo systemctl enable --now pacman-filesdb-refresh.timer

sudo grub-install
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo chmod +750 -R /usr/share/polkit-1/rules.d # Instead of 755

libinput-gestures-setup restart

# ghc-libs
# Settings file doesn't exist /usr/lib/ghc-9.2.8/lib/settings

# glusterfs
# https://gluster.readthedocs.io/en/latest/Upgrade-Guide

/usr/bin/cups-genppdupdate

sudo systemctl restart cups

# rp-pppoe
# Kernel-mode plugin moved to /usr/lib/rp-pppoe/rp-pppoe.so
# Change "LINUX_PLUGIN" to the new path in your /etc/ppp/pppoe.conf

systemctl --user restart opentabletdriver

rustup self upgrade-data

# sudo dkms install --no-depmod nvidia/550.90.09 -k 6.9.3-zen1-1-zen --force
# sudo dkms install --no-depmod vboxhost/7.0.18_OSE -k 6.9.3-zen1-1-zen --force
