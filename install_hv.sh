#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

cd "$HOME"/dotfiles

if ! [ -d "$HOME"/.apps ]; then
  mkdir -p "$HOME"/.apps
  sync
fi

if ! [ -d "$HOME"/dotfiles/backup/.config ]; then
  mkdir -p "$HOME"/dotfiles/backup/.config
  sync
fi

if ! [ -d "$HOME"/dotfiles/backup/.local/share ]; then
  mkdir -p "$HOME"/dotfiles/backup/.local/share
  sync
fi

if ! [ -d "$HOME"/dotfiles/backup/Pictures ]; then
  mkdir -p "$HOME"/dotfiles/backup/Pictures
  sync
fi

if ! [ -d "$HOME"/dotfiles/backup/.config/menus ]; then
  mkdir -p "$HOME"/dotfiles/backup/.config/menus
  sync
fi

if ! [ -d "$HOME"/.config/menus ]; then
  mkdir -p "$HOME"/.config/menus
  sync
fi

if [ -f "$HOME"/.config/menus/applications.menu ]; then
  mv "$HOME"/.config/menus/applications.menu "$HOME"/dotfiles/backup/.config/menus/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/menus/applications.menu "$HOME"/.config/menus/

if [ -f "$HOME"/Pictures/Wallpapers ]; then
  mv "$HOME"/Pictures/Wallpapers "$HOME"/dotfiles/backup/Pictures/
  sync
fi
ln -svf "$HOME"/dotfiles/Pictures/Wallpapers "$HOME"/Pictures/

if [ -f "$HOME"/.bash_aliases ]; then
  mv "$HOME"/.bash_aliases "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.bash_aliases "$HOME"/

if [ -f "$HOME"/.xinitrc ]; then
  mv "$HOME"/.xinitrc "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.xinitrc "$HOME"/

if [ -f "$HOME"/.Xresources ]; then
  mv "$HOME"/.Xresources "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.Xresources "$HOME"/

if [ -f "$HOME"/.bashrc ]; then
  mv "$HOME"/.bashrc "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.bashrc "$HOME"/

if [ -f "$HOME"/.bash_profile ]; then
  mv "$HOME"/.bash_profile "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.bash_profile "$HOME"/

if [ -f "$HOME"/.profile ]; then
  mv "$HOME"/.profile "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.profile "$HOME"/

if [ -f "$HOME"/.editorconfig ]; then
  mv "$HOME"/.editorconfig "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.editorconfig "$HOME"/

if [ -f "$HOME"/.gtkrc-2.0.mine ]; then
  mv "$HOME"/.gtkrc-2.0.mine "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.gtkrc-2.0.mine "$HOME"/

if [ -f "$HOME"/.gitconfig ]; then
  mv "$HOME"/.gitconfig "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.gitconfig "$HOME"/

if [ -d "$HOME"/.tmux ]; then
  mv "$HOME"/.tmux "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.tmux "$HOME"/

if [ -f "$HOME"/.config/rofi ]; then
  mv "$HOME"/.config/rofi "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/rofi "$HOME"/.config/

if [ -f "$HOME"/.config/bat ]; then
  mv "$HOME"/.config/bat "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/bat "$HOME"/.config/

if [ -f "$HOME"/.config/gtk-3.0/. ]; then
  mv "$HOME"/.config/gtk-3.0/settings.ini "$HOME"/dotfiles/backup/.config/gtk-3.0/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/gtk-3.0/settings.ini "$HOME"/.config/gtk-3.0/

if [ -f "$HOME"/.config/gtk-4.0/. ]; then
  mv "$HOME"/.config/gtk-4.0/settings.ini "$HOME"/dotfiles/backup/.config/gtk-4.0/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/gtk-4.0/settings.ini "$HOME"/.config/gtk-4.0/

if [ -f "$HOME"/.config/picom.conf ]; then
  mv "$HOME"/.config/picom.conf "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/picom.conf "$HOME"/.config/

if [ -f "$HOME"/.config/dunst ]; then
  mv "$HOME"/.config/dunst "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/dunst "$HOME"/.config/

if [ -f "$HOME"/.local/share/rofi ]; then
  mv "$HOME"/.local/share/rofi "$HOME"/dotfiles/backup/.local/share/
  sync
fi
ln -svf "$HOME"/dotfiles/.local/share/rofi "$HOME"/.local/share/

if [ -f "$HOME"/.config/starship.toml ]; then
  mv "$HOME"/.config/starship.toml "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/starship.toml "$HOME"/.config/

if [ -d "$HOME"/.config/bat ]; then
  mv "$HOME"/.config/bat "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/bat "$HOME"/.config/

if [ -d "$HOME"/.config/kitty ]; then
  mv "$HOME"/.config/kitty "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/kitty "$HOME"/.config/

if [ -d "$HOME"/.config/nvim_minimum ]; then
  mv "$HOME"/.config/nvim_minimum "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/nvim_minimum "$HOME"/.config/nvim

if [ -d "$HOME"/.config/tmux ]; then
  mv "$HOME"/.config/tmux "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/tmux "$HOME"/.config/

if [ -f "$HOME"/activewindow.sh ]; then
  mv "$HOME"/activewindow.sh "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/scripts/activewindow.sh "$HOME"/

if [ -f "$HOME"/appify.sh ]; then
  mv "$HOME"/appify.sh "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/scripts/appify.sh "$HOME"/

sudo ln -sv "$HOME"/.gtkrc-2.0 /etc/gtk-2.0/gtkrc
sudo ln -sv "$HOME"/.config/gtk-3.0/settings.ini /etc/gtk-3.0/settings.ini

# Change pacman.conf
sudo sed -i "s/ParallelDownloads.*/ParallelDownloads = 20/g" /etc/pacman.conf
sync

sudo pacman -Syy

# PACMAN
PKGS=(

  # Tools
  'base-devel'
  'rustup'                  # Rust
  'meson'                   # High productivity build system
  'libconfig'               # C/C++ Configuration file library
  'gdb'                     # GNU Debugger
  'lldb'                    # High performance debugger
  'gcc'
  'cmake'
  'cmake-extras'
  'extra-cmake-modules'
  'make'
  'dkms'
  'linux611'
  'linux611-headers'

  # Filesystem
  'snapper'
  'snapper-gui'
  'btrfs-assistant'
  'btrfs-progs'
  'grub-btrfs'
  'snap-pac'
  'zfs-dkms'
  'zfs-utils'
  'nfs-utils'
  'libguestfs'
  'guestfs-tools'

  'neovim'                  # Good Text Editor
  'nano'
  'eza'
  'bat'
  'gparted'
  'filelight'               # Show disk usage analyzer
  'cups'
  'hplip'                   # Driver for HP Deskjet (All-in-One) printers
  'partitionmanager'        # Partitions Manager
  'skanlite'                # Image Scanning App (If you have a scanner or aio printer/scanner)
  'tmux'                    # Terminal Multiplexer
  'yazi'                    # Terminal file manager
  'zoxide'                  #
  'fzf'                     # Fuzzy finder
  'git-delta'               #

  # Fonts
  'inter-font'              # Daily "Industry-Standard" font SIL Open Font License v1.0
  'ttf-jetbrains-mono'      # Dev "Industry-Standard" font SIL Open Font License v1.0
  'ttf-jetbrains-mono-nerd' # Wizard "Industry-Standard" font SIL Open Font License v1.0
  'noto-fonts'              # Noto fonts
  'noto-fonts-extra'        # Additional variants of noto fonts
  'noto-fonts-cjk'          # Chinese Japanese Korean (CJK) characters support
  'noto-fonts-emoji'        # Support for emojis
  'ttf-firacode-nerd'       # My personal favorite font for programming
  'powerline-fonts'         # Patched fonts for powerline
  # 'ttf-ms-fonts'            # Patched fonts for powerline

  # Shell/Terminal
  'starship'                # Terminal customizable prompt for shells
  'qalculate-qt'            # Terminal Calculator
  'autojump'                #
  'bash-completion'
  'kitty'
  'kitty-shell-integration'
  'kitty-terminfo'

  # Audio
  'manjaro-pipewire'
  'pipewire-jack'
  'pipewire-zeroconf'
  'jack-example-tools'

  # Bluetooth
  'bluez'
  'bluez-utils'
  'bluez-libs'
  'blueman'

  # VM
  # 'qemu-full'
  'qemu-desktop'
  'libvirt'
  'virt-manager'
  # 'virt-viewer'
  'edk2-ovmf'
  # 'vde2'
  'dmidecode'
  'dnsmasq'
  'bridge-utils'
  'openbsd-netcat'
  # 'ebtables'
  'iptables-nft'
  'swtpm'
  'power-profiles-daemon'
  'remmina'

  # Neovim "Dependencies"
  'ripgrep'
  'fd'
  'shfmt'
  'shellcheck'
  'lazygit'
  'vscode-json-languageserver'
  'lua-language-server'
  'bash-language-server'
  'luarocks'

  # LSP
  'python-pip' # Required to install some LSP servers
  'npm'        # Required to install some LSP servers
  'lua-language-server'
  'shellharden'

  # Looking Glass Dependencies
  'libgl'
  'libegl'
  'fontconfig'
  'spice-protocol'
  'nettle'
  'pkgconf'
  'binutils'
  'libxi'
  'libxinerama'
  'libxss'
  'libxcursor'
  'libxpresent'
  'libxkbcommon'
  'wayland-protocols'
  'ttf-dejavu'
  'libsamplerate'

  # Misc
  'downgrade'
  'xdg-desktop-portal-kde'
  'xdg-desktop-portal'
  'sassc'
  'gtk-engine-murrine'
  'gnome-themes-extra'
  'gnome-tweaks'
  'polkit'
  'polkit-kde-agent'
  'brave-browser'
  'fastfetch'
  'thefuck'
  'fontconfig'
  'lib32-fontconfig'
  'dconf-editor'
  'rofi'
  'xorg-xprop'
  'xorg-xwininfo'
  'xdotool'
  'xorg-xrandr'
  'dunst'
  'dunstify'
  'pulseaudio'
  'python-dbus'
  'playerctl'
  'pavucontrol'
  # 'figlet'                      # Make large letters out of text
  'freerdp'                     # RDP Software
  'tumbler'                     # D-Bus thumbnailing service
  # 'papirus-icon-theme'          # Theme
  'ark'                         # (KDE) (Un)packer software
  #
  'dolphin'                     # (KDE) File manager
  'dolphin-plugins'             # (KDE) Plugins for Dolphin
  'kdegraphics-thumbnailers'
  # 'kimageformats'
  # 'libheif'
  # 'qt6-imageformats'
  # 'resvg'
  # 'kdesdk-thumbnailers'
  'ffmpegthumbs'
  # 'taglib'
  # 'kio-extras'
  #
  'gwenview'                    # (KDE) Image viewer
  'kate'                        # (KDE) Text Editor
  'kleopatra'                   # (KDE) Certificate Manager
  'okular'                      # (KDE) Document Viewer
  'gio-qt'
  'btop'
  'flameshot'
  'jq'
  # 'jre21-openjdk'
  # 'jdk21-openjdk'
  # 'xboxdrv'                     # Gamepad driver for Linux (Controller Support)
  # 'gamemode'
  # 'lib32-gamemode'
  # 'libappindicator-gtk3'
  # 'gnome-icon-theme'
  # 'libayatana-appindicator'
  # 'php'
  # 'libnotify'
  # 'distrobox'
  # 'expressvpn'
  # 'xdg-desktop-portal-gtk'
  # 'archlinux-xdg-menu'
  # 'polkit'
  # 'polkit-kde-agent'
  # 'polkit-gnome'
  # 'gnome-themes-extra'
  # 'xwaylandvideobridge'
  # 'godot-mono'
  # 'linux-steam-integration'
  # 'vulkan-tools'
  # 'texlive-bin'
  # 'texlive-xetex'
  # 'texlive-luatex'
  # 'dvisvgm'
  # 'zotero-bin'
  # 'ncompress'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | sudo pacman -S "$PKG" --needed
  sync
  sleep 1s
done

cd "$HOME"/dotfiles/apps/paru
makepkg -si
sync

cd "$HOME"/dotfiles

luarocks config local_by_default true
luarocks install lua-utils

# This key is hit or miss, let's run it just to be sure
gpg --keyserver hkps://pgp.surf.nl --recv-keys ABAF11C65A2970B130ABE3C479BE3E4300411886

# PARU
PKGPARU=(
  # Themes
  'catppuccin-gtk-theme-mocha'
  'catppuccin-cursors-mocha'
  'kvantum-theme-catppuccin-git'
  'papirus-folders-catppuccin-git'
  'papirus-icon-theme-git'
  'qt5-styleplugins'
  'qt6gtk2'
  'gtk2-patched-filechooser-icon-view'
  'gtk3-patched-filechooser-icon-view'

  # Shell/Terminal
  'autojump'                # Faster way to navigate filesystem

  # Tools
  'tuned'                   #
  'rar'                     # Rar AND Unrar
  'find-the-command'    # Hook for bash, fish and zsh to find
  'driverctl'

  # Xanmod
  'linux-xanmod'
  'linux-xanmod-headers'
  'looking-glass-dkms-module'

  # Misc
  'qalculate-qt'                # Calculator
  'snapper-tools'
  'snapper-support'
  'pa-applet'
)

for PKG in "${PKGPARU[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  paru -S "$PKG" --noconfirm --needed --sudoloop
  sync
  sleep 1s
done

# Create snapper config for root and home partitions
sudo snapper -c root create-config /
sudo snapper -c root create --description "initial snapshot"
sudo snapper -c home create-config /home
sudo snapper -c home create --description "initial snapshot"

# Give access to root and home
sudo sed -i "s|ALLOW_USERS=\".*|ALLOW_USERS=\"$(logname)\"|g" /etc/snapper/configs/root
sudo sed -i "s|ALLOW_USERS=\".*|ALLOW_USERS=\"$(logname)\"|g" /etc/snapper/configs/home

# Timeline cleanup
sudo sed -i "s|TIMELINE_LIMIT_HOURLY=\".*|TIMELINE_LIMIT_HOURLY=\"12\"|g" /etc/snapper/configs/root
sudo sed -i "s|TIMELINE_LIMIT_DAILY=\".*|TIMELINE_LIMIT_DAILY=\"5\"|g" /etc/snapper/configs/root
sudo sed -i "s|TIMELINE_LIMIT_WEEKLY=\".*|TIMELINE_LIMIT_WEEKLY=\"2\"|g" /etc/snapper/configs/root
sudo sed -i "s|TIMELINE_LIMIT_MONTHLY=\".*|TIMELINE_LIMIT_MONTHLY=\"1\"|g" /etc/snapper/configs/root
sudo sed -i "s|TIMELINE_LIMIT_QUARTERLY=\".*|TIMELINE_LIMIT_QUARTERLY=\"0\"|g" /etc/snapper/configs/root
sudo sed -i "s|TIMELINE_LIMIT_YEARLY=\".*|TIMELINE_LIMIT_YEARLY=\"0\"|g" /etc/snapper/configs/root

sudo sed -i "s|TIMELINE_LIMIT_HOURLY=\".*|TIMELINE_LIMIT_HOURLY=\"12\"|g" /etc/snapper/configs/home
sudo sed -i "s|TIMELINE_LIMIT_DAILY=\".*|TIMELINE_LIMIT_DAILY=\"5\"|g" /etc/snapper/configs/home
sudo sed -i "s|TIMELINE_LIMIT_WEEKLY=\".*|TIMELINE_LIMIT_WEEKLY=\"2\"|g" /etc/snapper/configs/home
sudo sed -i "s|TIMELINE_LIMIT_MONTHLY=\".*|TIMELINE_LIMIT_MONTHLY=\"1\"|g" /etc/snapper/configs/home
sudo sed -i "s|TIMELINE_LIMIT_QUARTERLY=\".*|TIMELINE_LIMIT_QUARTERLY=\"0\"|g" /etc/snapper/configs/home
sudo sed -i "s|TIMELINE_LIMIT_YEARLY=\".*|TIMELINE_LIMIT_YEARLY=\"0\"|g" /etc/snapper/configs/home

# echo
# echo "usermod -aG users $(logname)"
# echo
# sudo usermod -aG users "$(logname)"
# sleep 1s

# sudo chown :root /.snapshots
# sudo chmod 750 /.snapshots
# sudo chown :root /home/.snapshots
# sudo chmod 755 /home/.snapshots

sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer
sudo systemctl enable --now grub-btrfs-snapper.path

echo
echo "Setting yazi as paru's File Manager"
echo
sudo sed -i "s|\#\[bin]|[bin]|g" /etc/paru.conf
sudo sed -i "s|#FileManager.*|FileManager = yazi|g" /etc/paru.conf
sync

fc-cache --force
fc-cache-32 --force

tmux source "$HOME"/.config/tmux/tmux.conf

# PIP
PKGT=(
  # LSP
  'argcomplete'
  'grip'
  'pynvim'
)

for PKG in "${PKGT[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  pip install --break-system-packages "$PKG"
  sync
  sleep 1s
done

echo
echo "Enabling npm's tab completion"
echo
sudo npm install --global all-the-package-names
sleep 1s

echo
echo "Updating npm to latest version"
echo
sudo npm install -g npm@latest
sleep 1s

echo
echo "Auditting and fixing npm's issues/vulnerabilities (if there's any)"
echo
npm i --package-lock-only
sync
npm audit fix
sleep 1s

# NPM
PKGTS=(
  # LSP
  'vscode-langservers-extracted'
  'markdownlint'
  'marked'
)

for PKG in "${PKGTS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  sudo npm i -g "$PKG"
  sync
  sleep 1s
done

echo
echo "Installing stable version of Rustup"
echo
rustup install stable
sync

echo
echo "Addidng i686 architecture support for Rustup"
echo
rustup target install i686-unknown-linux-gnu
sync

echo
echo "Setting stable as our default Rustup toolchain"
echo
rustup default stable
sync

echo
echo "Setting Cargo to run commands in parallel"
echo
cargo install async-cmd
sync

echo
echo 'Installing Spotifyctl'
echo
cd "$HOME"/dotfiles/apps/spotifyctl
cargo install --path .
sync
cd "$HOME"/dotfiles

echo
echo "Enabling tuned"
echo
sudo systemctl enable --now tuned.service
sudo tuned-adm profile virtual-host
sync
sleep 1s

if [ -d "$HOME"/.fonts ]; then
  mv "$HOME"/.fonts "$HOME"/dotfiles/backup/
  sync
fi

if [ -d "$HOME"/.icons ]; then
  mv "$HOME"/.icons "$HOME"/dotfiles/backup/
  sync
fi

if [ -d "$HOME"/.themes ]; then
  mv "$HOME"/.themes "$HOME"/dotfiles/backup/
  sync
fi

sudo sed -i 's/Inherits*/Inherits=Papirus-Dark/g' /usr/share/icons/default/index.theme

sudo cp -ur "$HOME"/dotfiles/themes/GTKTheme/* /usr/share/themes/
sync

cp -ur /usr/share/fonts "$HOME"/.fonts
cp -ur /usr/share/icons "$HOME"/.icons
cp -ur /usr/share/themes "$HOME"/.themes
cp -ur /usr/share/fonts "$HOME"/.local/share/
cp -ur /usr/share/icons "$HOME"/.local/share/
cp -ur /usr/share/themes "$HOME"/.local/share/
sync

cd "$HOME"/.icons/Papirus/
curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && chmod +x ./papirus-folders
sudo cp papirus-folders "$HOME"/.local/share/icons/Papirus/
sudo cp papirus-folders /usr/share/icons/Papirus/
sync

cd /usr/share/icons/Papirus/
./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
sync
cd "$HOME"/.icons/Papirus/
./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
sync
cd "$HOME"/.local/share/icons/Papirus/
./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
sync

ln -svf "$HOME"/.themes/Catppuccin-Dark/gtk-2.0/* "$HOME"/.config/gtk-2.0/
ln -svf "$HOME"/.themes/Catppuccin-Dark/gtk-3.0/* "$HOME"/.config/gtk-3.0/
ln -svf "$HOME"/.themes/Catppuccin-Dark/gtk-4.0/* "$HOME"/.config/gtk-4.0/
sync

sudo mkdir -p /etc/xdg/menus
sudo rm /etc/xdg/menus/applications.menu
sudo cp "$HOME"/.config/menus/applications.menu /etc/xdg/menus/

fc-cache --force
fc-cache-32 --force

# btrfs defrag
if ! [[ grep -q autodefrag /etc/fstab ]]; then
  sudo sed -i 's/compress=zstd/x-mount.mkdir,compress=zstd:3,space_cache=v2,autodefrag/g' /etc/fstab
  sync
fi

# Noatime
if ! [[ grep -q noatime /etc/fstab ]]; then
  sudo sed -i 's/discard=async/discard=async,noatime/g' /etc/fstab
  sync
fi

# Clear cache
if ! [[ grep -q clear_cache /etc/fstab ]]; then
  sudo sed -i 's/ssd/ssd,clear_cache/g' /etc/fstab
  sync
fi

cd apps/qemu-9.0.1/
# git apply ../qemu-9.0.1.patch # Already done
# ./configure # Already done
sudo make install -j"$(nproc)"

cd "$HOME"/dotfiles

echo
echo "usermod -aG video qemu"
echo
sudo usermod -aG video qemu
sleep 1s

echo
echo "usermod -aG kvm,libvirt,libvirt-qemu,video \"$(logname)\""
echo
sudo usermod -aG kvm,libvirt,libvirt-qemu,video "$(logname)"
sleep 1s

echo
echo "Enabling libvirtd"
echo
sudo systemctl enable --now libvirtd
sleep 1s
# sudo systemctl enable --now virtqemud.socket
# sleep 1s

echo
echo "gpasswd -M $(logname) kvm"
echo
sudo gpasswd -M "$(logname)" kvm
sleep 1s
echo
echo "gpasswd -M $(logname) libvirt"
echo
sudo gpasswd -M "$(logname)" libvirt
sleep 1s

echo
echo "Enabling VIRSH internal network automatically at boot"
echo
sudo virsh net-autostart default
sleep 1s

cpath=$PWD

echo
echo "Backing up \"/etc/libvirt/libvirtd.conf\" to \"/etc/libvirt/libvirtd.conf.old\""
echo
sudo mv /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.old
sleep 1s
echo
echo "Copying \"""$cpath/SGPUPT/config/libvirtd.conf\" to \"/etc/libvirt\""
echo
sudo cp "$cpath"/SGPUPT/config/libvirtd.conf /etc/libvirt
sleep 1s
echo
echo "Backing up \"/etc/libvirt/qemu.conf\" to \"/etc/libvirt/qemu.conf.old\""
echo
sudo mv /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.old
sleep 1s
echo
echo "Copying \"""$cpath/SGPUPT/config/qemu.conf\" to \"/etc/libvirt\""
echo
sudo cp "$cpath"/SGPUPT/config/qemu.conf /etc/libvirt
sleep 1s

if grep -qF "user=\"USERNAME\"" /etc/libvirt/qemu.conf; then
    echo
    echo "Adding \"$(logname)\" to qemu.conf's user"
    echo
    sudo sed -i "s|user=\"USERNAME\".*|user=\"$(logname)\"|g" /etc/libvirt/qemu.conf
    sleep 1s
fi

sudo mkdir -p /etc/libvirt/hooks


sudo mkdir -p /etc/libvirt/hooks/qemu.d && sudo wget 'https://asus-linux.org/files/vfio/libvirt_hooks/qemu' -O /etc/libvirt/hooks/qemu && sudo chmod +x /etc/libvirt/hooks/qemu
sudo systemctl restart libvirt

echo 'Xcursor.theme: Catppuccin-Mocha-Mauve-Cursors' | tee -a "$HOME"/.Xresources
echo 'Xcursor.size: 48' | tee -a "$HOME"/.Xresources

echo 'xset r rate 300 60' | tee -a "$HOME"/.xinitrc
echo 'xrdb ~/.Xresources' | tee -a "$HOME"/.xinitrc

cd "$HOME"/dotfiles/apps/tdrop
sudo make install
sync
sleep 1s
sudo make install
sync
sleep 1s

cd "$HOME"/dotfiles

make -C "$HOME"/dotfiles/apps/ble.sh install PREFIX="$HOME"/.local
sync

GRUB="$(cat /etc/default/grub | grep "GRUB_CMDLINE_LINUX_DEFAULT" | rev | cut -c 2- | rev)"

if sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o amd; then
    GRUB+=" amd_iommu=on iommu=pt\""
    sync
    sleep 1s
elif sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o intel; then
    GRUB+=" intel_iommu=on iommu=pt\""
    sync
    sleep 1s
fi

GRUB=`cat /etc/default/grub | grep "GRUB_CMDLINE_LINUX_DEFAULT" | rev | cut -c 2- | rev`

GRUB+=" systemd.unified_cgroup_hierarchy=1 kvm.ignore_msrs=1 kvm.report_ignored_msrs=0 pcie_acs_override=downstream,multifunction vfio_iommu_type1.allow_unsafe_interrupts=1\""
sync

sudo sed -i "s/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/g" /etc/default/grub
sync
sudo sed -i "s/GRUB_DEFAULT=.*/GRUB_DEFAULT=0/g" /etc/default/grub
sync

sudo update-grub

echo
echo "Enabling nested kvm"
echo

if ! [[ -d /etc/modprobe.d ]]; then
    echo
    echo "Creating \"/etc/modprobe.d\" folder"
    echo
    sudo mkdir -p /etc/modprobe.d
    sync
    sleep 1s
fi

if sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o amd; then
    if ! [[ -f /etc/modprobe.d/kvm-amd.conf ]]; then
        sudo touch /etc/modprobe.d/kvm-amd.conf
        sync
        sleep 1s
    fi

    printf "options kvm_amd nested=1\noptions kvm ignore_msrs=1\noptions kvm report_ignored_msrs=0\n" | sudo tee /etc/modprobe.d/kvm-amd.conf
    sync
    sudo modprobe -r kvm-amd
    sudo modprobe kvm-amd
    sleep 1s
elif sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o intel; then
    if ! [[ -f /etc/modprobe.d/kvm-intel.conf ]]; then
        sudo touch /etc/modprobe.d/kvm-intel.conf
        sync
        sleep 1s
    fi

    printf "options kvm-intel nested=1\noptions kvm ignore_msrs=1\noptions kvm report_ignored_msrs=0\noptions kvm-intel enable_shadow_vmcs=1\noptions kvm-intel enable_apicv=1\noptions kvm-intel ept=1\n" | sudo tee /etc/modprobe.d/kvm-intel.conf
    sync
    sudo modprobe -r kvm-intel
    sudo modprobe kvm-intel
    sleep 1s
fi

cd "$HOME"/.apps/

wget https://looking-glass.io/artifact/stable/source -O looking-glass-B6.tar.gz
sync
tar xvzf looking-glass-B6.tar.gz
sync

mkdir client/build && sync && cd client/build

cmake ../
sync
make
sync
sudo make install
sync

cd "$HOME"/dotfiles

printf "#KVMFR Looking Glass Module\noptions kvmfr static_size_mb=128\n" | sudo tee /etc/modprobe.d/kvmfr.conf

printf "SUBSYSTEM==\"kvmfr\", OWNER=\"$(logname)\", GROUP=\"kvm\", MODE=\"0660\"\n" | sudo tee /etc/udev/rules.d/99-kvmfr.rules

printf "# Type Path               Mode UID  GID Age Argument\n\n" | sudo tee /etc/tmpfiles.d/10-looking-glass.conf
printf "f /dev/shm/looking-glass 0660 %s kvm -\n" "$(logname)" | sudo tee -a /etc/tmpfiles.d/10-looking-glass.conf

printf "# KVMFR Looking Glass module\nkvmfr\n" | sudo tee /etc/modules-load.d/kvmfr.conf

MKINITCPIO="$(cat /etc/mkinitcpio.conf | grep "MODULES" | rev | cut -c 2- | rev)"
MKINITCPIO+=" vfio vfio_iommu_type1 vfio_pci kvmfr)"
sleep 1s

sudo mkinitcpio -P

sudo systemctl daemon-reload
sudo systemctl restart systemd-udevd.service
sudo systemctl restart libvirtd

sudo modprobe vfio-pci
sudo modprobe vfio
sudo modprobe vfio-iommu-type1
sudo modprobe kvmfr static_size_mb=128
sleep 1s

sudo chown "$(logname)":kvm /dev/kvmfr0

export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
# export QT_STYLE_OVERRIDE=kvantum
export GTK2_RC_FILES=/home/archuser/.gtkrc-2.0
export XCURSOR_THEME=catppuccin-mocha-mauve-cursors
export XCURSOR_SIZE=48
export GTK_THEME=Catppuccin-Dark
export GDK_USE_PORTAL=1
export GDK_DEBUG=portals
export XDG_DESKTOP_PORTAL=1
export GSK_RENDERER=gl
export GDK_DEBUG=gl-no-fractional
export NO_AT_BRIDGE=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1

printf "QT_QPA_PLATFORMTHEME=qt5ct:qt6ct\n" | sudo tee -a /etc/environment
# printf "QT_STYLE_OVERRIDE=kvantum\n" | sudo tee -a /etc/environment
printf "GTK2_RC_FILES=/home/archuser/.gtkrc-2.0\n" | sudo tee -a /etc/environment
printf "XCURSOR_THEME=catppuccin-mocha-mauve-cursors\n" | sudo tee -a /etc/environment
printf "XCURSOR_SIZE=48\n" | sudo tee -a /etc/environment
printf "GTK_THEME=Catppuccin-Dark\n" | sudo tee -a /etc/environment
printf "GTK_USE_PORTAL=1\n" | sudo tee -a /etc/environment
printf "GDK_DEBUG=portals\n" | sudo tee -a /etc/environment
printf "XDG_DESKTOP_PORTAL=1\n" | sudo tee -a /etc/environment
printf "GSK_RENDERER=gl\n" | sudo tee -a /etc/environment
printf "GDK_DEBUG=gl-no-fractional\n" | sudo tee -a /etc/environment
printf "NO_AT_BRIDGE=1\n" | sudo tee -a /etc/environment
printf "DOTNET_CLI_TELEMETRY_OPTOUT=1\n" | sudo tee -a /etc/environment

echo
echo 'Enabling timer for regular files database updates'
echo
systemctl enable pacman-filesdb-refresh.timer

printf "keyserver hkps://keys.openpgp.org\n" | tee -a ~/.gnupg/gpg.conf
printf "keyserver hkps://pgp.surf.nl\n" | tee -a ~/.gnupg/gpg.conf
printf "keyserver hkps://pgp.mit.edu\n" | tee -a ~/.gnupg/gpg.conf
printf "keyserver hkps://keyserver.ubuntu.com\n" | tee -a ~/.gnupg/gpg.conf
printf "keyserver hkp://keys.gnupg.net\n" | tee -a ~/.gnupg/gpg.conf
printf "keyserver hkp://pgp.rediris.es\n" | tee -a ~/.gnupg/gpg.conf

# Adding DNS0
printf "DNS=193.110.81.0#dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
printf "DNS=2a0f:fc80::#dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
printf "DNS=185.253.5.0#dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
printf "DNS=2a0f:fc81::#dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
printf "DNSOverTLS=yes" | sudo tee -a /etc/systemd/resolved.conf

sudo sed -i 's/\(firewall_backend *= *\).*/\1iptables/' /etc/libvirt/network.conf

echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'net.ipv4.conf.default.rp_filter=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'net.ipv4.conf.all.rp_filter=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'net.bridge.bridge-nf-call-ip6tables=0' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'net.bridge.bridge-nf-call-iptables=0' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'net.bridge.bridge-nf-call-arptables=0' | sudo tee -a /etc/sysctl.d/99-sysctl.conf

sudo sysctl --system

# ZERO DNS0 (also blocks newly created domains)
# printf "DNS=193.110.81.9#zero.dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
# printf "DNS=2a0f:fc80::9#zero.dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
# printf "DNS=185.253.5.9#zero.dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
# printf "DNS=2a0f:fc81::9#zero.dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
# printf "DNSOverTLS=yes" | sudo tee -a /etc/systemd/resolved.conf

sudo systemctl enable systemd-resolved.service
sudo systemctl enable fstrim.timer
sudo systemctl enable sshd.service
sudo systemctl enable cups.service
sudo systemctl enable bluetooth.service
sudo systemctl enable btrfs-scrub@-.timer
sudo systemctl enable btrfs-scrub@home.timer
sudo systemctl enable nftables.service
cupsenable

echo
echo 'Symlink your backed up .gnupg and .ssh folder as well your *.local files to your home folder'
echo 'Then run the following commands:'
echo 'eval "$(ssh-agent -s)"'
echo 'ssh-add ~/.ssh/id_ed25519'
echo 'Change id_ed25519 to the actual file'
echo
echo "You must run both qt5ct and qt6ct and adjust their themes, icons, etc accordingly"
echo
echo "For uecli to work you must run 'ue4 setroot /path/to/UnrealEngine-5.4.1'"
echo
echo "Run otd-gui to configure your non-wacom Tablet"
echo
echo "Configure SGDBoop, go to the following site and follow instructions"
echo 'https://www.steamgriddb.com/boop'
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
