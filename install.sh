#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

if ! [ -d ~/.apps ]; then
  mkdir -p ~/.apps
  sync
fi

if [ -f ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.bash_aliases ~/

if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/.bashrc ~/

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

if [ -d ~/.config/hypr ]; then
  mv ~/.config/hypr ~/dotfiles/backup/.config/
  sync
fi
ln -svf ~/dotfiles/.config/hypr ~/.config/

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

if [ -d ~/.doom.d ]; then
  mv ~/.doom.d ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/emacs/doom/.doom.d ~/

if [ -d ~/.stemacs.d ]; then
  mv ~/.stemacs.d ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/emacs/stemacs/.stemacs.d ~/

if [ -f ~/activewindow.sh ]; then
  mv ~/activewindow.sh ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/scripts/activewindow.sh ~/

if [ -f ~/appify.sh ]; then
  mv ~/appify.sh ~/dotfiles/backup/
  sync
fi
ln -svf ~/dotfiles/scripts/appify.sh ~/

sync

export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# PACMAN
PKGS=(
  # Tools
  'rustup'                  # Rust
  'meson'                   # High productivity build system
  'mingw-w64'               # MinGW Cross-compiler pack (binutils, crt, gcc, headers and winpthreads)
  'libconfig'               # C/C++ Configuration file library
  'gdb'                     # GNU Debugger
  'lldb'                    # High performance debugger
  'bear'                    # C++ compilation database generator
  'cmake'
  'extra-cmake-modules'

  'flatpak'                 # Mostly Sandboxed Package Manager
  'flatpak-xdg-utils'       # Tools for Flatpak
  'neovim'                  # Good Text Editor
  'emacs-wayland'           # OS with bad text editor
  'grim'                    # Grimshot dependency
  'slurp'                   # Grimshot dependency
  'grimshot'                # Screenshot App
  'hplip'                   # Driver for HP Deskjet (All-in-One) printers
  'filelight'               # Show disk usage analyzer
  'partitionmanager'        # Partitions Manager
  'skanlite'                # Image Scanning App (If you have a scanner or aio printer/scanner)
  'tmux'                    # Terminal Multiplexer
  'vifm'                    # Vim-like file manager
  'tuned'                   #
  'zoxide'                  #
  'fzf'                     # Fuzzy finder
  'git-delta'               #
  'thefuck'                 # Auto correct past mistakes in terminal
  'syncthing'

  # Fonts
  'noto-fonts'       # Additional variants of noto fonts
  'noto-fonts-extra'       # Additional variants of noto fonts
  'noto-fonts-cjk'         # Chinese Japanese Korean (CJK) characters support
  'noto-fonts-emoji'       # Support for emojis
  'ttf-firacode-nerd'       # My personal favorite font for programming
  'powerline-fonts'         # Patched fonts for powerline
  'ttf-ms-fonts'         # Patched fonts for powerline

  # Themes
  'catppuccin-gtk-theme-mocha'
  'catppuccin-cursors-mocha'
  'papirus-icon-theme'

  # Shell/Terminal
  'starship'                # Terminal customizable prompt for shells
  'qalculate-qt'            # Terminal Calculator
  'autojump'                #

  # VM
  'qemu-full'
  'libvirt'
  'virt-manager'
  'edk2-ovmf'

  # Neovim "Dependencies"
  'ripgrep'
  'fd'
  'shfmt'
  'shellcheck'
  'lazygit'
  'omnisharp-roslyn'
  'vscode-json-languageserver'
  'lua-language-server'
  'rust-analyzer'
  'yaml-language-server'
  'bash-language-server'
  'go'

  # LSP
  'python-pip' # Required to install some LSP servers
  'npm'        # Required to install some LSP servers
  'yarn'       # Required to install some LSP servers
  'lua-language-server'
  'bash-language-server'
  'rust-analyzer'
  # C Sharp
  'dotnet-sdk-6.0'
  'dotnet-sdk-7.0'
  'mono'
  'mono-msbuild'
  'libuv'

  # Emacs "dependencies"
  'aspell'
  'enchant'
  'hunspell'
  'gnuplot'
  'maim'
  'hydra'
  'ispell'
  'aspell-en'
  'aspell-pt'
  'hunspell-en_us'
  'hunspell-en_gb'
  'hunspell-pt-br'
  'direnv'
  'docker'
  'docker-buildx'
  'docker-compose'
  'docker-machine'
  'zig'
  'zls'
  'nim'
  'nimble'
  'sqlite'
  'sqlitebrowser'
  'graphviz'

  # Misc
  'figlet'                      # Make large letters out of text
  'freerdp'                     # RDP Software
  'tumbler'                     # D-Bus thumbnailing service
  'papirus-icon-theme'          # Theme
  'ark'                         # (KDE) (Un)packer software
  'dolphin'                     # (KDE) File manager
  'dolphin-plugins'             # (KDE) Plugins for Dolphin
  'gwenview'                    # (KDE) Image viewer
  'kate'                        # (KDE) Text Editor
  'kleopatra'                   # (KDE) Certificate Manager
  'okular'                      # (KDE) Document Viewer
  'gwenview'                    # (KDE) Image Viewer
  'qalculate-qt'                # Calculator
  'btop'
  'jre21-openjdk'
  'jdk21-openjdk'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  sudo pacman -S "$PKG" --noconfirm --needed
  sync
done

# PARU
# PKGPARU=(
#   ''
# )
#
# for PKG in "${PKGPARU[@]}"; do
#   echo
#   echo "INSTALLING: ${PKG}"
#   echo
#   paru -S "$PKG" --noconfirm --needed --sudoloop
#   sync
# done

# PIP
PKGT=(
  # LSP
  'cmake-language-server'
  'gdtoolkit'
  'argcomplete'
  'grip'
)

for PKG in "${PKGT[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  pip install --break-system-packages "$PKG"
  echo
  sleep 1s
done

# NPM
PKGTS=(
  # LSP
  'vscode-langservers-extracted'
  'sql-language-server'
  'dockerfile-language-server-nodejs'
  'markdownlint'
  'marked'
)

for PKG in "${PKGTS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  sudo npm i -g "$PKG"
  echo
  sleep 1s
done

# YARN
PKGST=(
  # LSP
  'yaml-language-server'
)

for PKG in "${PKGST[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yarn global add "$PKG"
  echo
  sleep 1s
done

# GO
PKGGO=(
  # LSP
  'golang.org/x/tools/gopls@latest'
)

for PKG in "${PKGGO[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  go install "$PKG"
  echo
  sleep 1s
done

export DOCKFMT_SHA256="f6bc025739cf4f56287e879c75c11cc73ebafdf93a57c9bcd8805d1ab82434a0"
sudo curl -fSL "https://github.com/jessfraz/dockfmt/releases/download/v0.3.3/dockfmt-linux-amd64" -o "/usr/local/bin/dockfmt"
echo "${DOCKFMT_SHA256}  /usr/local/bin/dockfmt" | sha256sum -c -
sudo chmod a+x "/usr/local/bin/dockfmt"

export DOTNET_ROOT=$HOME/.dotnet
export PATH="$PATH:/root/.dotnet/tools"

PKGDN=(
  # LSP
  'csharp-ls'
  'csharpier'
)

for PKG in "${PKGDN[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  dotnet tool install --global "$PKG"
  echo
  sleep 1s
done

echo
echo "Adding flathub"
echo
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sync

# Flatpak
PKGFP=(
  # Main
  'com.github.tchx84.Flatseal'                    # Flatpak permission manager
  'org.libreoffice.LibreOffice'                    # Open-source office suite ("replaces" MS Word, PowerPoint and Excel)
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
  'com.unity.UnityHub'                            # Game Engine

  # Games/Game Related
  'com.heroicgameslauncher.hgl'                   # Epic Games and GOG launcher
  'com.valvesoftware.Steam'                       # Steam
  'net.lutris.Lutris'                             # Lutris
  'io.github.achetagames.epic_asset_manager'      # Epic Games' Marketplace for Linux
  'io.gdevs.GDLauncher'                           # Minecraft Launcher
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

sed -i "s/font-family.*/font-family: FiraCode Nerd Font Mono\;/g" "$HOME"/.config/waybar/style.css

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

echo 'XDG_CONFIG_HOME="$HOME/.config"' | sudo tee -a /etc/environment
sync
echo 'DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1' | sudo tee -a /etc/environment
sync
echo 'DOTNET_ROOT=$HOME/.dotnet' | sudo tee -a /etc/environment
sync
echo 'PATH="$PATH:/root/.dotnet/tools"' | sudo tee -a /etc/environment
sync

echo
echo 'Installing DOOM Emacs'
echo
"$HOME"/dotfiles/emacs/doom/doomemacs/bin/doom install

emacs &
sleep 5s
sudo killall -9 emacs
sleep 5s
"$HOME"/dotfiles/emacs/doom/doomemacs/bin/doom sync
sleep 1s

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

# Enabling autologin
sudo sed -i "0,/\[Autologin\]/s//\[Autologin\]\nUser\=$(logname)/" /etc/sddm.conf

echo
echo "Setting up fq_pie queue discipline for TCP congestion control"
echo
echo 'net.core.default_qdisc = fq_pie' | sudo tee /etc/sysctl.d/90-override.conf
sleep 1s

echo
echo "Amending journald Logging to 200M"
echo
sudo sed -i "s|#SystemMaxUse=.*|SystemMaxUse=200M|g" /etc/systemd/journald.conf
sleep 1s

echo
echo "Restricting Kernel Log Access"
echo
sudo sysctl -w kernel.dmesg_restrict=1
sleep 1s

if ! [ -f /etc/sysctl.d/99-sysctl.conf ]; then
  sudo touch /etc/sysctl.d/99-sysctl.conf
fi

printf "fs.inotify.max_user_instances\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.inotify.max_user_watches=524288\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "vm.max_map_count=262144\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.tcp_fin_timeout=5\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.sched_cfs_bandwidth_slice_us=3000\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.core.rmem_max=2621440\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.core.wmem_max=2621440\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.core_pattern=|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.core_pipe_limit=16\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.suid_dumpable=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.sysrq=16\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.core_uses_pid=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.default.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.docker0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.enp34s0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.lo.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.tun0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.vboxnet0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.virbr0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.default.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.docker0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.enp34s0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.lo.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.tun0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.vboxnet0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.virbr0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.default.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.docker0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.enp34s0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.lo.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.tun0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.vboxnet0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.virbr0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.ping_group_range=0 2147483647\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.core.default_qdisc=fq_codel\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.protected_hardlinks=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.protected_symlinks=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.protected_regular=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.protected_fifos=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.pid_max=4194304\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.aio-max-nr=1048576\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "vm.unprivileged_userfaultfd=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "vm.swappiness=133\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.nmi_watchdog=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.unprivileged_userns_clone=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.printk=3 3 3 3\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.sysrq=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
sync
sudo sysctl --system
sleep 1s

# Enable services
sudo systemctl enable fstrim.timer
sudo systemctl enable sshd.service
sudo systemctl enable btrfs-scrub@-.timer
sudo systemctl enable btrfs-scrub@home.timer
sleep 1s

cd "$HOME"/dotfiles/apps/hdrop
sudo make install
sync
sleep 1s
sudo make install
sync
sleep 1s

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
