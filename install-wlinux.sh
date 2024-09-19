#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

# This is for SSHFS, if it's not configured, sshfs config will be ignored
LNAME=null
IPADD=null
PATH=null

# Path you want to put your Unreal Engine Editor
UEPATH=null

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

if [ -d "$HOME"/.config/tmux ]; then
  mv "$HOME"/.config/tmux "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/tmux "$HOME"/.config/

if [ -f "$HOME"/.bashrc ]; then
  mv "$HOME"/.bashrc "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.bashrc "$HOME"/

if [ -f "$HOME"/.config/picom.conf ]; then
  mv "$HOME"/.config/picom.conf "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/picom.conf "$HOME"/.config/

if [ -f "$HOME"/.bash_aliases ]; then
  mv "$HOME"/.bash_aliases "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.bash_aliases "$HOME"/

if [ -f "$HOME"/.config/starship.toml ]; then
  mv "$HOME"/.config/starship.toml "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/starship.toml "$HOME"/.config/

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
  'extra-cmake-modules'
  'make'
  'dkms'
  'clang'
  # 'distrobox'
  # 'podman'

  # Game Engines
  'godot'
  'godot-mono'

  # Terminal
  'kitty'
  'kitty-shell-integration'
  'kitty-terminfo'
  'tmux'
  'autojump'
  'starship'

  # Neovim "Dependencies"
  'ripgrep'
  'fd'
  'shfmt'
  'lazygit'
  'lua-language-server'
  'bash-language-server'
  'python-pip'
  'npm'
  'luarocks'

  # Fonts
  'inter-font'
  'ttf-jetbrains-mono'
  'ttf-jetbrains-mono-nerd'
  'noto-fonts'
  'noto-fonts-extra'
  'noto-fonts-cjk'
  'noto-fonts-emoji'
  'ttf-firacode-nerd'
  'powerline-fonts'

  # tdrop "Dependencies"
  'xorg-xprop'
  'xorg-xwininfo'
  'xdotool'

  # Tmux "Dependencies"
  'xsel'

  # Nvidia installer
  'nvidia-inst'

  # Ble.sh "Dependencies"
  'thefuck'
  'zoxide'
  'ugrep'
  'fastfetch'

  # Misc "Dependencies"
  'xorg-xhost'

  # Deskflow "Dependencies"
  'ninja'
  'openssl'
  'glib2'
  'gdk-pixbuf2'
  'libxtst'
  'libnotify'
  'libxkbfile'
  'gtest'
  'pugixml'
  'libei'
  'libportal'
  'qt6-base'
  'qt6-tools'
  'gtk3'

  # Unreal Engien Dependencies
  'alsa-lib'
  'at-spi2-core'
  'glu'
  'lttng-ust2.12'
  'nss'
  'pango'
  'mono'
  'coreutils'
  'dos2unix'
  'dotnet-runtime-7.0'
  'dotnet-sdk-7.0'
  'findutils'
  'lld'
  'openssl'
  'python'
  'sdl2'
  'steam'
  'vulkan-icd-loader'
  'xdg-user-dirs'
  'git'
  'glibc'
  'grep'
  'openssh'
  'sed'
  'wget'
  'cmake'
  'pacman-contrib'
  'polly'
  'qt5-base'
  'qt6-base'
  'code'

  # Misc
  'gnome-keyring'
  'picom'
  'eza'
  'bat'
  'yazi'
  'fzf'
  'sshfs'
  'flatpak'                 # Mostly Sandboxed Package Manager
  'flatpak-xdg-utils'       # Tools for Flatpak
  'flatpak-builder'                 # Mostly Sandboxed Package Manager
  'p7zip'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | sudo pacman -S "$PKG" --needed
  sync
done

export CARGO_BUILD_JOBS=$(( $(nproc) + 1 ))
export MAKEFLAGS=-j$(( $(nproc) + 1 ))
sudo sed -i "s/.*MAKEFLAGS.*/MAKEFLAGS=\"-j\$(( \$(nproc) + 1 ))\"/g" /etc/makepkg.conf
printf "\nCARGO_BUILD_JOBS=%s\n" $(( $(nproc) + 1 )) | sudo tee -a /etc/environment
sudo sed -i "s/BROWSER=.*/BROWSER=$HOME/.local/share/flatpak/exports/share/applications/com.brave.Browser.desktop/g" /etc/environment

echo
echo "Adding flathub"
echo
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sync

# Flatpak
PKGFP=(
  # Main
  'com.github.tchx84.Flatseal'                            # Flatpak permission manager
  'org.libreoffice.LibreOffice'                           # Open-source office suite ("replaces" MS Word, PowerPoint and Excel)
  'md.obsidian.Obsidian'                                  # A knowledge base that works on local Markdown files
  'com.github.eneshecan.WhatsAppForLinux'                 # Messaging App
  'org.qbittorrent.qBittorrent'                           # Torrent app
  'info.smplayer.SMPlayer'                                # Media Player
  'io.mpv.Mpv'                                            # Media player
  'io.github.shiftey.Desktop'                             # Github Desktop app
  'org.telegram.desktop'                                  # Messaging App

  # Wine
  'org.winehq.Wine//stable-23.08'                         # Windows Compatibility Layer
  'org.winehq.Wine.mono//stable-23.08'                    # .NET Framework implementation for Wine based on Mono
  'org.winehq.Wine.gecko//stable-23.08'                   # Web engine for Wine based on Mozilla Gecko
  'org.winehq.Wine.DLLs.dxvk//stable-23.08'               # Vulkan-based implementation of D3D9, D3D10 and D3D11 for Linux / Wine
  'com.github.Matoking.protontricks'                      # Wrapper to make winetricks work with Proton
  'org.phoenicis.playonlinux'                             # GUI front-end for wine. "PlayOnLinux's Designated Successor"

  # Browser
  'org.torproject.torbrowser-launcher'                    # Tor Browser
  'net.mullvad.MullvadBrowser'                            # Mullvad Browser
  'com.brave.Browser'                                     # Brave Browser

  'com.spotify.Client'                                    # Spotify
  'io.github.Qalculate.qalculate-qt'                      # Calculator
  'nl.hjdskes.gcolor3'                                    # Color Picker
  'org.kde.kleopatra'                                     # Certificate Manager and Unified Crypto GUI
  'org.kde.okteta'                                        # Hex Editor
  'com.bitwarden.desktop'                                 # Password Manager
  'org.getmonero.Monero'                                  # Crypto
  'org.eclipse.Java'                                      # Needed for M$ TFVC (Terrible Fucking Version Control)
#    ''         #
)

for PKG in "${PKGFP[@]}"; do
    echo
    echo "INSTALLING: ${PKG}"
    echo
    flatpak --user install flathub "$PKG" -y --or-update
    echo
    sync
done

cd "$HOME"/dotfiles/apps/paru
makepkg -si
sync

cd "$HOME"/dotfiles

luarocks config local_by_default true
luarocks install lua-utils

sudo pacman -Rsn rar --noconfirm --unneeded

# PARU
PKGPARU=(
  # Shell/Terminal
  'autojump'              # Faster way to navigate filesystem

  # Tools
  'rar'                   # Rar AND Unrar
  'find-the-command'      # Hook for bash, fish and zsh to find

  # Xanmod
  'linux-xanmod'          # Xanmod Kernel
  'linux-xanmod-headers'  # Headers for Xanmod

  # Unity "Dependencies"
  'gconf'
  'libicu50'
  'icu70'

  # Unreal Engine Dependencies
  'icu63'
  'ttf-ms-fonts'

  # Game Engines
  'unityhub'
  # 'unreal-engine-git'
  'eam-git'
  'vscodium'
  'vscodium-features'
  'vscodium-marketplace'
)

for PKG in "${PKGPARU[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  paru -S "$PKG" --noconfirm --needed --sudoloop
  sync
done

# PIP
PKGT=(
  # LSP
  'argcomplete'
  'pynvim'
)

for PKG in "${PKGT[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  pip install --break-system-packages "$PKG"
  sync
done

sync
nvidia-inst --32 --conf
sync

pip install --user pynvim --break-system-packages
sync

rustup install stable
sync

rustup target install i686-unknown-linux-gnu
sync

rustup default stable
sync

cargo install async-cmd
sync

cargo install shellharden
sync

cd ~/dotfiles/apps/tdrop
sudo make install
sync

tmux source "$HOME"/.config/tmux/tmux.conf
."$HOME"/.tmux/plugins/tpm/bin/install_plugins
sync

make -C "$HOME"/dotfiles/apps/ble.sh install PREFIX="$HOME"/.local
sync

cd "$HOME"/dotfiles

printf "\nDNS=193.110.81.0#dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
printf "DNS=2a0f:fc80::#dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
printf "DNS=185.253.5.0#dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
printf "DNS=2a0f:fc81::#dns0.eu\n" | sudo tee -a /etc/systemd/resolved.conf
printf "DNSOverTLS=yes\n" | sudo tee -a /etc/systemd/resolved.conf
sync

sudo systemctl enable --now systemd-resolved.service
sync
sudo ln -svf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sync

sudo groupadd fuse
sudo usermod -a -G fuse "$(logname)"

mkdir "$HOME"/SHARED

sshfs "$LNAME@$IPADD:$PATH" "$HOME"/SHARED

"$LNAME@$IPADD:$PATH" "$HOME"/SHARED fuse.sshfs

FSTABOPTS="defaults,x-systemd.automount,_netdev,user,idmap=user,reconnect,follow_symlinks,identityfile=$HOME/.ssh/id_rsa,allow_other,default_permissions,uid=1000,gid=1000"
printf "\n%s@%s:%s  /home/archuser/SHARED fuse.sshfs %s 0 0\n" "$LNAME" "$IPADD" "$PATH" "$FSTABOPTS" | sudo tee -a /etc/fstab
sudo systemctl daemon-reload

ssh-keygen -t rsa -f "$HOME"/.ssh/sshfs_rsa

echo
echo "Copy $HOME/.ssh/sshfs_rsa.pub to the Host's authorized keys, like so"
echo
echo "ssh-copy-id -i $HOME/.ssh/sshfs_rsa.pub $LNAME@$IPADD"
echo
echo
echo
echo "Then, in the Host, you'll copy it to the authorized_keys file, like so"
echo
echo "cat $HOME/sshfs_rsa.pub >> $HOME/.ssh/authorized_keys"
echo

exit 0
