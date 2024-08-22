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

if [ -d "$HOME"/.config/nvim ]; then
  mv "$HOME"/.config/nvim "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/nvim "$HOME"/.config/

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
  'rustup'                  # Rust
  'meson'                   # High productivity build system
  'libconfig'               # C/C++ Configuration file library
  'gdb'                     # GNU Debugger
  'lldb'                    # High performance debugger
  'cmake'
  'cmake-extras'
  'extra-cmake-modules'
  'make'

  'snapper'
  'snapper-gui'
  'btrfs-assistant'
  'btrfs-progs'
  'grub-btrfs'
  'snap-pac'

  'neovim'                  # Good Text Editor
  'nano'
  'eza'
  'bat'
  'gparted'
  'filelight'               # Show disk usage analyzer
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
  'noto-fonts'              # Additional variants of noto fonts
  # 'noto-fonts-extra'        # Additional variants of noto fonts
  # 'noto-fonts-cjk'          # Chinese Japanese Korean (CJK) characters support
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

  # VM
  'qemu-full'
  'libvirt'
  'virt-manager'
  'edk2-ovmf'
  'dmidecode'
  'dnsmasq'
  'ebtables'
  'iptables-nft'
  'swtpm'

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

  # Misc
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
  # 'figlet'                      # Make large letters out of text
  'freerdp'                     # RDP Software
  'tumbler'                     # D-Bus thumbnailing service
  # 'papirus-icon-theme'          # Theme
  'ark'                         # (KDE) (Un)packer software
  #
  'dolphin'                     # (KDE) File manager
  'dolphin-plugins'             # (KDE) Plugins for Dolphin
  # 'kdegraphics-thumbnailers'
  # 'kimageformats'
  # 'libheif'
  # 'qt6-imageformats'
  # 'resvg'
  # 'kdesdk-thumbnailers'
  # 'ffmpegthumbs'
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

# PARU
PKGPARU=(
  # Themes
  'catppuccin-gtk-theme-mocha'
  'catppuccin-cursors-mocha'
  'kvantum-theme-catppuccin-git'
  'papirus-icon-theme-git'
  'papirus-folders-catppuccin-git'
  'qt5-styleplugins'
  'qt6gtk2'

  # Shell/Terminal
  'autojump'                # Faster way to navigate filesystem

  # Tools
  'tuned'                   #
  'rar'                     # Rar AND Unrar
  'find-the-command'    # Hook for bash, fish and zsh to find

  # Xanmod
  'linux-xanmod'
  'linux-xanmod-headers'

  # Misc
  'qalculate-qt'                # Calculator
  'snapper-tools'
  'snapper-support'
)

for PKG in "${PKGPARU[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  paru -S "$PKG" --noconfirm --needed --sudoloop
  sync
  sleep 1s
done

sudo snapper -c root create-config /
sudo snapper -c root create --description "initial snapshot"
sudo chmod a+rx /.snapshots
sudo chown :users /.snapshots

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

cp -ur /usr/share/fonts "$HOME"/.fonts
cp -ur /usr/share/icons "$HOME"/.icons
cp -ur /usr/share/themes "$HOME"/.themes

fc-cache --force
fc-cache-32 --force

# Enabling btrfs defrag
if ! [[ grep -q autodefrag /etc/fstab ]]; then
  sudo sed -i 's/compress=zstd/compress=zstd,autodefrag/g' /etc/fstab
  sync
fi

echo
echo "usermod -aG video qemu"
echo
sudo usermod -aG video qemu
sleep 1s

echo
echo "usermod -aG kvm,libvirt,video \"$(logname)\""
echo
sudo usermod -aG kvm,libvirt,video "$(logname)"
sleep 1s

echo
echo "Enabling libvirtd"
echo
sudo systemctl enable --now libvirtd
sleep 1s

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

GRUB="$(cat /etc/default/grub | grep "GRUB_CMDLINE_LINUX_DEFAULT" | rev | cut -c 2- | rev)"

if sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o amd; then
    GRUB+=" amd_iommu=on iommu=pt\""
    sleep 1s
elif sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o intel; then
    GRUB+=" intel_iommu=on iommu=pt\""
    sleep 1s
fi

sudo sed -i "s/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/g" /etc/default/grub
sudo sed -i "s/GRUB_DEFAULT=.*/GRUB_DEFAULT=0/g" /etc/default/grub

sudo update-grub

MKINITCPIO="$(cat /etc/mkinitcpio.conf | grep "MODULES" | rev | cut -c 2- | rev)"
MKINITCPIO+=" vfio vfio_pci vfio_iommu_type1)"
sleep 1s

sudo mkinitcpio -P

sudo modprobe vfio-pci
sudo modprobe vfio
sudo modprobe vfio-iommu-type1
sleep 1s

export QT_QPA_PLATFORMTHEME=qt6ct
export GTK2_RC_FILES=/home/archuser/.gtkrc-2.0
export XCURSOR_THEME=Catppuccin-Mocha-Mauve-Cursors
export XCURSOR_SIZE=48
export GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark
export DOTNET_CLI_TELEMETRY_OPTOUT=1

printf "QT_QPA_PLATFORMTHEME=qt6ct\n" | sudo tee -a /etc/environment
printf "GTK2_RC_FILES=/home/archuser/.gtkrc-2.0\n" | sudo tee -a /etc/environment
printf "XCURSOR_THEME=Catppuccin-Mocha-Mauve-Cursors\n" | sudo tee -a /etc/environment
printf "XCURSOR_SIZE=48\n" | sudo tee -a /etc/environment
printf "GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark\n" | sudo tee -a /etc/environment
printf "DOTNET_CLI_TELEMETRY_OPTOUT=1\n" | sudo tee -a /etc/environment

echo
echo 'Enabling timer for regular files database updates'
echo
systemctl enable pacman-filesdb-refresh.timer

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
