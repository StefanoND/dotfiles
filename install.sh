#!/bin/bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

if [ -f ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.bash_aliases ~/

if [ -f ~/.bash_logout ]; then
  mv ~/.bash_logout ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.bash_logout ~/

if [ -f ~/.bash_profile ]; then
  mv ~/.bash_profile ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.bash_profile ~/

if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.bashrc ~/

if [ -f ~/.dircolors ]; then
  mv ~/.dircolors ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.dircolors ~/

if [ -f ~/.editorconfig ]; then
  mv ~/.editorconfig ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.editorconfig ~/

if [ -f ~/.gitattributes ]; then
  mv ~/.gitattributes ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.gitattributes ~/

if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.gitconfig ~/

if [ -f ~/.gtkrc-2.0.mine ]; then
  mv ~/.gtkrc-2.0.mine ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.gtkrc-2.0.mine ~/

if [ -f ~/.profile ]; then
  mv ~/.profile ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.profile ~/

# Wezterm config
# if [ -f ~/.wezterm.lua ]; then
#   mv ~/.wezterm.lua ~/dotfiles/backup/
#   sync
# fi
# ln -svf ~/dotfiles/.wezterm.lua ~/

if [ -f ~/.config/starship.toml ]; then
  mv ~/.config/starship.toml ~/dotfiles/backup/.config/
  sync
fi
ln -svf ~/dotfiles/.config/starship.toml ~/.config/

if [ -d ~/.config/bat ]; then
  mv ~/.config/bat ~/dotfiles/backup/.config/
  sync
fi
ln -svf ~/dotfiles/.config/bat ~/.config/

if [ -d ~/.config/godot ]; then
  mv ~/.config/godot ~/dotfiles/backup/.config/
  sync
fi
ln -svf ~/dotfiles/.config/godot ~/.config/

# i3
# if [ -d ~/.config/i3 ]; then
#   mv ~/.config/i3 ~/dotfiles/backup/.config/
#   sync
# fi
# ln -svf ~/dotfiles/.config/i3 ~/.config/

if [ -d ~/.config/kitty ]; then
  mv ~/.config/kitty ~/dotfiles/backup/.config/
  sync
fi
ln -svf ~/dotfiles/.config/kitty ~/.config/

if [ -d ~/.config/nvim ]; then
  mv ~/.config/nvim ~/dotfiles/backup/.config/
  sync
fi
ln -svf ~/dotfiles/.config/nvim ~/.config/

# if [ -d ~/.config/picom ]; then
#   mv ~/.config/picom ~/dotfiles/backup/.config/
#   sync
# fi
# ln -svf ~/dotfiles/.config/picom ~/.config/

if [ -d ~/.config/tmux ]; then
  mv ~/.config/tmux ~/dotfiles/backup/.config/
  sync
fi
ln -svf ~/dotfiles/.config/tmux ~/.config/

# if [ -d ~/.config/VSCodium ]; then
#   mv ~/.config/VSCodium ~/dotfiles/backup/.config/
#   sync
# fi
# ln -svf ~/dotfiles/.config/VSCodium ~/.config/

if [ -f ~/.firedragon/firedragon.overrides.cfg ]; then
  mv ~/.firedragon/firedragon.overrides.cfg ~/dotfiles/backup/.firedragon/
  sync
fi
ln -svf ~/dotfiles/.firedragon/firedragon.overrides.cfg ~/.firedragon/

if [ -d ~/.omnisharp ]; then
  mv ~/.omnisharp ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.omnisharp ~/

sync

export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# PACMAN
PKGS=(
  'rustup'                  # Rust
  'meson'                   # High productivity build system
  'mingw-w64'               # MinGW Cross-compiler pack (binutils, crt, gcc, headers and winpthreads)
  'libconfig'               # C/C++ Configuration file library
  'gdb'                     # GNU Debugger
  'lldb'                    # High performance debugger
  'flatpak'                 # Mostly Sandboxed Package Manager
  'flatpak-xdg-utils'       # Tools for Flatpak
  'neovim'                  # Good Text Editor
  'emacs-wayland'           # OS with bad text editor
  'hdrop'                   # TDrop for Wayland
  'grim'                    # Grimshot dependency
  'slurp'                   # Grimshot dependency
  'grimshot'                # Screenshot App
  'hplip'                   # Driver for HP Deskjet (All-in-One) printers
  'filelight'               # Show disk usage analyzer
  'partitionmanager'        # Partitions Manager
  'skanlite'                # Image Scanning App (If you have a scanner or aio printer/scanner)
  'tmux'                    # Terminal Multiplexer
  'vifm'                    # Vim-like file manager
  'ttf-firacode-nerd'       # My personal favorite font for programming
  'tuned'                   #
  'zoxide'                  #
  'fzf'                     # Fuzzy finder
  'git-delta'               #
  'thefuck'                 # Auto correct past mistakes in terminal
  'autojump'                #

  # VM
  'qemu-full'
  'libvirt'
  'virt-manager'
  'edk2-ovmf'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  sudo pacman -S "$PKG" --noconfirm --needed
  sync
done

export DOTNET_ROOT=$HOME/.dotnet
export PATH="$PATH:/root/.dotnet/tools"

echo
echo "Adding flathub"
echo
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sync

# Flatpak
PKGFP=(
  # Main
  'com.github.tchx84.Flatseal'                    # Flatpak permission manager
  'rg.libreoffice.LibreOffice'                    # Open-source office suite ("replaces" MS Word, PowerPoint and Excel)
  'md.obsidian.Obsidian'                          # A knowledge base that works on local Markdown files
  'org.telegram.desktop'                          # Messaging App
  'com.discordapp.Discord'                        # VoIP app
  'com.github.eneshecan.WhatsAppForLinux'         # Messaging App
  'org.qbittorrent.qBittorrent'                   # Torrent app
  'org.tenacityaudio.Tenacity'                    # Audio Recorder and Editor
  'com.obsproject.Studio'                         # Streaming software
  'info.smplayer.SMPlayer'                        # Media Player
  'io.mpv.Mpv'                                    # Media player
  'org.kde.krita'                                 # Digital Painting Software
  'org.gimp.GIMP'                                 # GNU Image Manipulator
  'org.inkscape.Inkscape'                         # Vector Graphics Editor
  'org.blender.Blender'                           # 3D Modelling Software
  'fr.handbrake.ghb'                              # Transcoder
  'io.github.shiftey.Desktop'                     # Github Desktop app
  'com.visualstudio.code'                         # VSCode, required for *some* game engines generate project files properly

  # Games/Game Related
  'com.heroicgameslauncher.hgl'                   # Epic Games and GOG launcher
  'com.valvesoftware.Steam'                       # Steam
  'net.lutris.Lutris'                             # Lutris
  'io.github.achetagames.epic_asset_manager'      # Epic Games' Marketplace for Linux
  'net.davidotek.pupgui2'                         # ProtonUp-Qt
  'io.github.antimicrox.antimicrox'               # Graphical program used to map gamepad keys to keyboard, mouse, scripts and macros

  # Wine
  'org.winehq.Wine'                               # Windows Compatibility Layer for Linux
  'com.github.Matoking.protontricks'              # Wrapper to make winetricks work with Proton
  'org.phoenicis.playonlinux'                     # GUI front-end for wine. "PlayOnLinux's Designated Successor"

  # VM
  'org.gnome.Boxes'                               # VM
  'com.usebottles.bottles'                        # VM Bottles

  # Browser
  'com.github.micahflee.torbrowser-launcher'      # Tor Browser
  'net.mullvad.MullvadBrowser'                    # Mullvad Browser
  'org.mozilla.firefox'                           # Firefox Browser

  'com.spotify.Client'                            # Spotify
  'io.github.Qalculate.qalculate-qt'              # Calculator
  'nl.hjdskes.gcolor3'                            # Color Picker
  'org.kde.kleopatra'                             # Certificate Manager and Unified Crypto GUI
  'org.kde.okteta'                                # Hex Editor
  'com.bitwarden.desktop'                         # Password Manager
#    ''         #
)

for PKG in "${PKGFP[@]}"; do
    echo
    echo "INSTALLING: ${PKG}"
    echo
    flatpak install --user flathub "$PKG" -y --or-update
    echo
    sync
done

echo
echo "Adding Valve aur repo to the mirror list"
echo
sleep 1s
printf "[valveaur]\n" | sudo tee -a /etc/pacman.conf
sync
printf "Server = http://repo.steampowered.com/arch/valveaur\n" | sudo tee -a /etc/pacman.conf
sync
sudo pacman -Syy

sed -i "s/font-family.*/font-family:FiraCode Nerd Font Mono/g" "$HOME"/.config/waybar/style.css

# Change pacman.conf
sudo sed -i "s/ParallelDownloads.*/ParallelDownloads = 20/g" /etc/pacman.conf
sync

# Enabling btrfs defrag
if ! "$(grep -q autodefrag /etc/fstab)"; then
  sudo sed -i 's/compress=zstd/compress=zstd,autodefrag/g' /etc/fstab
  sync
fi

echo
echo "Setting vifm as paru's File Manager"
echo
sudo sed -i "s|\#\[bin]|[bin]|g" /etc/paru.conf
sudo sed -i "s|#FileManager|FileManager|g" /etc/paru.conf
sync

echo 'DOTNET_ROOT=$HOME/.dotnet' | sudo tee -a /etc/environment
sync
echo 'PATH="$PATH:/root/.dotnet/tools"' | sudo tee -a /etc/environment
sync
echo 'DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1' | sudo tee -a /etc/environment
sync

echo
echo "Enabling tuned"
echo
sudo systemctl enable --now tuned.service
sudo tuned-adm profile virtual-host
sync
sleep 1s

echo
printf "Linking /usr/share/fonts to %s/.fonts" "$HOME"
echo
ln -svf /usr/share/fonts "$HOME"/.fonts
sync

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
echo "Enabling btrfs's automatic balance at 10% threshold"
echo
sudo bash -c "echo 10 > /sys/fs/btrfs/$(sudo blkid -s UUID -o value /dev/mapper/root)/allocation/data/bg_reclaim_threshold"
sync
sleep 1s
sudo bash -c "echo 10 > /sys/fs/btrfs/$(sudo blkid -s UUID -o value /dev/mapper/home)/allocation/data/bg_reclaim_threshold"
sync
sleep 1s

# Enable services
sudo systemctl enable fstrim.timer
sudo systemctl enable btrfs-scrub@-.timer
sudo systemctl enable btrfs-scrub@home.timer
sleep 1s

exit 0
