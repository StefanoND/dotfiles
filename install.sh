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

if ! [ -d "$HOME"/Pictures/Grim ]; then
  mkdir -p "$HOME"/Pictures/Grim
  sync
fi

if ! [ -d "$HOME"/dotfiles/backup/.config ]; then
  mkdir -p "$HOME"/dotfiles/backup/.config
  sync
fi

if ! [ -d "$HOME"/dotfiles/backup/.firedragon ]; then
  mkdir -p "$HOME"/dotfiles/backup/.firedragon
  sync
fi

if ! [ -d "$HOME"/dotfiles/backup/etc/libinput ]; then
  mkdir -p "$HOME"/dotfiles/backup/etc/libinput
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

if [ -f "$HOME"/.bash_aliases ]; then
  mv "$HOME"/.bash_aliases "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.bash_aliases "$HOME"/

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

if [ -f "$HOME"/.editorconfig ]; then
  mv "$HOME"/.editorconfig "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.editorconfig "$HOME"/

if [ -f "$HOME"/.gitattributes ]; then
  mv "$HOME"/.gitattributes "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.gitattributes "$HOME"/

if [ -f "$HOME"/.gitconfig ]; then
  mv "$HOME"/.gitconfig "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.gitconfig "$HOME"/

# Wezterm config
# if [ -f $HOME/.wezterm.lua ]; then
#   mv $HOME/.wezterm.lua $HOME/dotfiles/backup/
#   sync
# fi
# ln -svf $HOME/dotfiles/.wezterm.lua $HOME/

if [ -d "$HOME"/.tmux ]; then
  mv "$HOME"/.tmux "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.tmux "$HOME"/

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

if [ -d "$HOME"/.config/cura ]; then
  mv "$HOME"/.config/cura "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/cura "$HOME"/.config/

if [ -d "$HOME"/.config/godot ]; then
  mv "$HOME"/.config/godot "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/godot "$HOME"/.config/

if [ -d "$HOME"/.config/hypr ]; then
  mv "$HOME"/.config/hypr "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/hypr "$HOME"/.config/

# i3
# if [ -d $HOME/.config/i3 ]; then
#   mv $HOME/.config/i3 $HOME/dotfiles/backup/.config/
#   sync
# fi
# ln -svf $HOME/dotfiles/.config/i3 $HOME/.config/

if [ -d "$HOME"/.config/kitty ]; then
  mv "$HOME"/.config/kitty "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/kitty "$HOME"/.config/

if [ -d "$HOME"/.config/mako ]; then
  mv "$HOME"/.config/mako "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/mako "$HOME"/.config/

if [ -f "$HOME"/.config/menus/applications.menu ]; then
  mv "$HOME"/.config/menus/applications.menu "$HOME"/dotfiles/backup/.config/menus/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/menus/applications.menu "$HOME"/.config/menus/

if [ -d "$HOME"/.config/nvim ]; then
  mv "$HOME"/.config/nvim "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/nvim "$HOME"/.config/

# if [ -d $HOME/.config/picom ]; then
#   mv $HOME/.config/picom $HOME/dotfiles/backup/.config/
#   sync
# fi
# ln -svf $HOME/dotfiles/.config/picom $HOME/.config/

if [ -d "$HOME"/.config/PrusaSlicer ]; then
  mv "$HOME"/.config/PrusaSlicer "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/PrusaSlicer "$HOME"/.config/

if [ -d "$HOME"/.config/SuperSlicer ]; then
  mv "$HOME"/.config/SuperSlicer "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/SuperSlicer "$HOME"/.config/

if [ -d "$HOME"/.config/tmux ]; then
  mv "$HOME"/.config/tmux "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/tmux "$HOME"/.config/

# if [ -d $HOME/.config/VSCodium ]; then
#   mv $HOME/.config/VSCodium $HOME/dotfiles/backup/.config/
#   sync
# fi
# ln -svf $HOME/dotfiles/.config/VSCodium $HOME/.config/

if [ -d "$HOME"/.config/waybar ]; then
  mv "$HOME"/.config/waybar "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/waybar "$HOME"/.config/

if [ -f "$HOME"/.firedragon/firedragon.overrides.cfg ]; then
  mv "$HOME"/.firedragon/firedragon.overrides.cfg "$HOME"/dotfiles/backup/.firedragon/
  sync
fi
ln -svf "$HOME"/dotfiles/.firedragon/firedragon.overrides.cfg "$HOME"/.firedragon/

if [ -d "$HOME"/.omnisharp ]; then
  mv "$HOME"/.omnisharp "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/.omnisharp "$HOME"/

if [ -d "$HOME"/.doom.d ]; then
  mv "$HOME"/.doom.d "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/emacs/doom/.doom.d "$HOME"/

if [ -d "$HOME"/.stemacs.d ]; then
  mv "$HOME"/.stemacs.d "$HOME"/dotfiles/backup/
  sync
fi
ln -svf "$HOME"/dotfiles/emacs/stemacs/.stemacs.d "$HOME"/

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

if ! [ -d "$HOME"/.config/systemd/user/graphical-session.target.wants ]; then
  mkdir -p "$HOME"/.config/systemd/user/graphical-session.target.wants
  sync
fi

if ! [ -d /etc/libinput ]; then
  sudo mkdir -p /etc/libinput
  sync
fi

if [ -f /etc/libinput/local-overrides.quirks ]; then
  sudo mv /etc/libinput/local-overrides.quirks "$HOME"/dotfiles/backup/etc/libinput/
  sync
fi
sudo cp "$HOME"/dotfiles/etc/libinput/local-overrides.quirks /etc/libinput/

sudo ln -sv "$HOME"/.gtkrc-2.0 /etc/gtk-2.0/gtkrc
sudo ln -sv "$HOME"/.config/gtk-3.0/settings.ini /etc/gtk-3.0/settings.ini

if [ -d "$HOME"/.config/frogminer ]; then
  mv "$HOME"/.config/frogminer "$HOME"/dotfiles/backup/.config/
  sync
fi
ln -svf "$HOME"/dotfiles/.config/frogminer "$HOME"/.config/

sudo cp "$HOME"/dotfiles/apps/steam-devices/60-steam-vr.rules /etc/udev/rules.d/
sudo cp "$HOME"/dotfiles/apps/steam-devices/60-steam-input.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules

sync

export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"

sudo pacman -Rsn thunar --noconfirm --unneeded

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
  'flatpak-builder'                 # Mostly Sandboxed Package Manager
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
  'syncthing'               #
  'nextcloud-client'        #

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
  'papirus-icon-theme-git'

  # Shell/Terminal
  'starship'                # Terminal customizable prompt for shells
  'qalculate-qt'            # Terminal Calculator
  'autojump'                #

  # VM
  'qemu-full'
  'libvirt'
  'virt-manager'
  'edk2-ovmf'
  'dmidecode'
  'dnsmasq'
  'ebtables'
  'iptables-nft'

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

  # Unreal Engine dependencies
  'dotnet-host'
  'dotnet-sdk'
  'dotnet-runtime'
  'dotnet-runtime-6.0'
  'dotnet-runtime-7.0'
  'babeltrace2'
  'icu'
  'libicu'
  'lttng-ust'
  'ncursers5-compat-libs'
  'vulkan-validation-layers'

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
  'aspnet-runtime'
  'aspnet-runtime-6.0'
  'aspnet-runtime-7.0'
  'dotnet-targeting-pack'
  'dotnet-targeting-pack-6.0'
  'dotnet-targeting-pack-7.0'
  'aspnet-targeting-pack'
  'aspnet-targeting-pack-6.0'
  'aspnet-targeting-pack-7.0'
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
  'kdegraphics-thumbnailers'
  'kimageformats'
  'libheif'
  'qt6-imageformats'
  'resvg'
  'kdesdk-thumbnailers'
  'ffmpegthumbs'
  'taglib'
  'kio-extras'

  'gwenview'                    # (KDE) Image viewer
  'kate'                        # (KDE) Text Editor
  'kleopatra'                   # (KDE) Certificate Manager
  'okular'                      # (KDE) Document Viewer
  'gwenview'                    # (KDE) Image Viewer
  'qalculate-qt'                # Calculator
  'btop'
  'jre21-openjdk'
  'jdk21-openjdk'
  'gio'
  'xboxdrv'                     # Gamepad driver for Linux (Controller Support)
  'gamemode'
  'lib32-gamemode'
  'libappindicator-gtk3'
  'gnome-icon-theme'
  'libayatana-appindicator'
  'php'
  'libnotify'
  'distrobox'
  'expressvpn'
  'xdg-desktop-portal-gtk'
  'polkit'
  'polkit-kde-agent'
  'polkit-gnome'
  'gnome-themes-extra'
  'modprobed-db'
  'cronie'
  'xwaylandvideobridge'
  'godot-mono'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | sudo pacman -S "$PKG" --needed
  sync
  sleep 1s
done

tmux source "$HOME"/.config/tmux/tmux.conf

if ! xdg-mime query default inode/directory | grep -iq "dolphin"; then
  xdg-mime default org.kde.dolphin.desktop inode/directory
fi

sudo sed -i 's/inode\/directory=.*/inode\/directory=org.kde.dolphin.desktop;/g' /usr/share/applications/mimeinfo.cache

kbuildsycoca6

# PARU
PKGPARU=(
  'libicu53'                    # Required for Unreal Engine
  'opentabletdriver'            # Tablet Driver ("-git" version not working)
)

for PKG in "${PKGPARU[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | paru -S "$PKG" --noconfirm --needed --sudoloop
  sync
  sleep 1s
done

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
  sync
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
  sync
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
  sync
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
  sync
  sleep 1s
done

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
  'com.discordapp.Discord'                                # VoIP app
  'com.github.eneshecan.WhatsAppForLinux'                 # Messaging App
  'org.qbittorrent.qBittorrent'                           # Torrent app
  'org.tenacityaudio.Tenacity'                            # Audio Recorder and Editor
  'info.smplayer.SMPlayer'                                # Media Player
  'io.mpv.Mpv'                                            # Media player
  'org.kde.krita'                                         # Digital Painting Software
  'org.inkscape.Inkscape'                                 # Vector Graphics Editor
  'org.blender.Blender'                                   # 3D Modelling Software
  'fr.handbrake.ghb'                                      # Transcoder
  'io.github.shiftey.Desktop'                             # Github Desktop app
  'com.visualstudio.code'                                 # VSCode, required for *some* game engines generate project files properly
  'com.unity.UnityHub'                                    # Game Engine

  # GIMP
  'org.gimp.GIMP'                                         # GNU Image Manipulator
  'org.gimp.GIMP.Plugin.Resynthesizer//2-40'              # Set of GIMP plug-ins that heal (in-paint), synthesize texture, theme an image, and more
  'org.gimp.GIMP.Plugin.LiquidRescale//2-40'              # LiquidRescale plugin to resize pictures non uniformly while preserving their features, i.e. avoiding distortion of the important parts.
  'org.gimp.GIMP.Plugin.Lensfun//2-40'                    # GimpLensfun is a Gimp plugin to correct lens distortion using the lensfun library and database.
  'org.gimp.GIMP.Plugin.GMic//2-40'                       # GREYC's Magic for Image Computing
  'org.gimp.GIMP.Plugin.Fourier//2-40'                    # A simple GIMP plug-in to do fourier transform on your image.
  'org.gimp.GIMP.Plugin.FocusBlur//2-40'                  # Focus Blur plug-in crete a blurring effect similar to Depth of Field.
  'org.gimp.GIMP.Plugin.BIMP//2-40'                       # Batch Image Manipulation Program, a GIMP plugin to apply a set of manipulations to an entire group of images!

  # Telegram
  'org.telegram.desktop'                                  # Messaging App
  'org.telegram.desktop.webview'                          # Webview support

  # OBS Studio
  'com.obsproject.Studio'                                 # Streaming software
  'com.obsproject.Studio.Plugin.VerticalCanvas'           # Add a vertical canvas to stream and record in secondary resolution, by Aitum
  'com.obsproject.Studio.Plugin.TransitionTable'          # Fine-tune your transitions with a transition table
  'com.obsproject.Studio.Plugin.SceneSwitcher'            # An advanced automated scene switcher for OBS Studio
  'com.obsproject.Studio.Plugin.ScaleToSound'             # Scale sources according to the sound of an audio source
  'com.obsproject.Studio.Plugin.RewardsTheater'           # An OBS plugin that lets your viewers redeem videos or sounds on stream via Twitch Channel Points
  'com.obsproject.Studio.Plugin.Ocr'                      # Extract and detect text in image and video inside OBS
  'com.obsproject.Studio.Plugin.OBSVkCapture'             # Capture Vulkan and OpenGL applications
  'com.obsproject.Studio.Plugin.OBSLivesplitOne'          # Add LiveSplit One as a source
  'com.obsproject.Studio.Plugin.NDI'                      # NewTek NDI integration for OBS Studio
  'com.obsproject.Studio.Plugin.MoveTransition'           # Moves source to a new position during scene transition
  'com.obsproject.Studio.Plugin.InputOverlay'             # Show keyboard, gamepad and mouse input on stream
  'com.obsproject.Studio.Plugin.Gstreamer'                # Encode streams and recordings using GStreamer
  'com.obsproject.Studio.Plugin.GStreamerVaapi'           # GStreamer-based VA-API encoder
  'com.obsproject.Studio.Plugin.DroidCam'                 # Use your phone as a camera source with the DroidCam app
  'com.obsproject.Studio.Plugin.BackgroundRemoval'        # Remove the background from your camera video

  # Games/Game Related
  'com.heroicgameslauncher.hgl'                           # Epic Games and GOG launcher
  'net.lutris.Lutris'                                     # Lutris
  'io.github.achetagames.epic_asset_manager'              # Epic Games' Marketplace for Linux
  'io.gdevs.GDLauncher'                                   # Minecraft Launcher
  'net.davidotek.pupgui2'                                 # ProtonUp-Qt
  'io.github.antimicrox.antimicrox'                       # Graphical program used to map gamepad keys to keyboard, mouse, scripts and macros
  'org.ryujinx.Ryujinx'                                   # Switch Emulator
  'org.yuzu_emu.yuzu'                                     # Switch Emulator
  'org.citra_emu.citra'                                   # 3DS Emulator
  'io.github.lime3ds.Lime3DS'                             # Citra Fork
  'info.cemu.Cemu'                                        # Wii U Emulator
  'io.github.dosbox-staging'                              # DOS/x86 Emulator
  'org.libretro.RetroArch'                                # Frontend for emulators, game engines and media players
  'org.freedesktop.Platform.VulkanLayer.gamescope//23.08' # Gamescope
  'com.steamgriddb.SGDBoop'
  'com.valvesoftware.Steam'                               # Steam
  'com.valvesoftware.Steam.CompatibilityTool.Boxtron'
  'com.valvesoftware.SteamLink'
  'org.freedesktop.Platform.VulkanLayer.MangoHud//23.08'
  'org.freedesktop.Platform.VulkanLayer.vkBasalt//23.08'

  # Wine
  'org.winehq.Wine//stable-23.08'                         # Windows Compatibility Layer
  'org.winehq.Wine.mono//stable-23.08'                    # .NET Framework implementation for Wine based on Mono
  'org.winehq.Wine.gecko//stable-23.08'                   # Web engine for Wine based on Mozilla Gecko
  'org.winehq.Wine.DLLs.dxvk//stable-23.08'               # Vulkan-based implementation of D3D9, D3D10 and D3D11 for Linux / Wine
  'com.github.Matoking.protontricks'                      # Wrapper to make winetricks work with Proton
  'org.phoenicis.playonlinux'                             # GUI front-end for wine. "PlayOnLinux's Designated Successor"

  # VM
  'org.gnome.Boxes'                                       # VM
  'org.gnome.Boxes.Extension.OsinfoDb'                    # OS Database for Gnome Boxes
  'com.usebottles.bottles'                                # VM Bottles

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
  'com.stremio.Stremio'                                   #
  'org.kde.KStyle.Kvantum//6.6'                           # Theme for QT apps
  'org.freedesktop.Platform.VulkanLayer.vkBasalt//23.08'  #
  'org.freedesktop.Platform.VulkanLayer.MangoHud//23.08'  #
  'org.freedesktop.Platform//23.08'                       #
  'org.freedesktop.Sdk//23.08'                            #
  'io.github.dvlv.boxbuddyrs'                             # GUI fo Distrobox
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

echo
echo "Fixing cursor and themes with flatpak apps"
echo
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

sudo usermod -aG docker "$(logname)"
sudo usermod -aG gamemode "$(logname)"
sudo usermod -aG input "$(logname)"

sudo sed -i 's/Inherits*/Inherits=Papirus-Dark/g' /usr/share/icons/default/index.theme

cp -ur /usr/share/fonts "$HOME"/.fonts
cp -ur /usr/share/icons "$HOME"/.icons
cp -ur /usr/share/themes "$HOME"/.themes

flatpak --user override --filesystem="$HOME"/.fonts/:ro
flatpak --user override --filesystem="$HOME"/.icons/:ro
flatpak --user override --filesystem="$HOME"/.themes/:ro
flatpak --user override --filesystem=xdg-config/gtk-3.0:ro
flatpak --user override --filesystem=xdg-config/Kvantum:ro
flatpak --user override --env=XCURSOR_PATH="$HOME"/.icons
flatpak --user override --env=XCURSOR_THEME=Catppuccin-Mocha-Mauve-Cursors
flatpak --user override --env=GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark
flatpak --user override --env=ICON_THEME=Papirus-Dark
flatpak --user override --env=QT_STYLE_OVERRIDE=kvantum
flatpak --user override --env=QT_QPA_PLATFORMTHEME=qt5ct,qt6ct

flatpak --user override --filesystem=~/.var/app/org.winehq.Wine net.lutris.Lutris
flatpak --user override --filesystem=~/.var/app/org.winehq.Wine.mono net.lutris.Lutris
flatpak --user override --filesystem=~/.var/app/org.winehq.Wine.gecko net.lutris.Lutris
flatpak --user override --filesystem=~/.var/app/org.winehq.Wine.DLLs.dxvk net.lutris.Lutris

flatpak --user override --filesystem=~/.var/app/com.valvesoftware.Steam net.lutris.Lutris
flatpak --user override --filesystem=~/.var/app/com.valvesoftware.Steam com.heroicgameslauncher.hgl
flatpak --user override --filesystem=~/.var/app/com.valvesoftware.Steam com.usebottles.bottles

flatpak --user override --env=MANGOHUD=1 com.valvesoftware.Steam

flatpak --user override --socket=wayland

# Workaround for Copy-Paste issues with lutris
flatpak --user override --env=QT_QPA_PLATFORM=xcb net.lutris.Lutris
flatpak --user override --env=QT_QPA_PLATFORM=xcb com.github.eneshecan.WhatsAppForLinux
# flatpak --user override --env=QT_QPA_PLATFORM=xcb io.github.spacingbat3.webcord
# flatpak --user override --socket=system-bus io.github.spacingbat3.webcord

flatpak --user override --env=QT_QPA_PLATFORM=xcb com.github.eneshecan.WhatsAppForLinux
flatpak --user override --filesystem="$HOME"/Pictures com.github.eneshecan.WhatsAppForLinux
flatpak --user override --filesystem="$HOME"/Documents com.github.eneshecan.WhatsAppForLinux
flatpak --user override --filesystem="$HOME"/Downloads com.github.eneshecan.WhatsAppForLinux

flatpak --user override --allow=bluetooth org.ryujinx.Ryujinx
flatpak --user override --allow=bluetooth org.citra_emu.citra
flatpak --user override --allow=bluetooth io.github.lime3ds.Lime3DS
flatpak --user override --allow=bluetooth org.yuzu_emu.yuzu

sync
sleep 1s

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
if ! [[ grep -q autodefrag /etc/fstab ]]; then
  sudo sed -i 's/compress=zstd/compress=zstd,autodefrag/g' /etc/fstab
  sync
fi

echo
echo "Setting vifm as paru's File Manager"
echo
sudo sed -i "s|\#\[bin]|[bin]|g" /etc/paru.conf
sudo sed -i "s|#FileManager|FileManager|g" /etc/paru.conf
sync

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

# grubgpu=""
if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
  echo 'options nouveau modeset=0' | sudo tee /etc/modprobe.d/blacklist-nvidia-nouveau.conf
  echo 'blacklist nouveau' | sudo tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
  echo 'blacklist lbm-nouveau' | sudo tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
  echo 'alias nouveau off' | sudo tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
  echo 'alias lbm-nouveau off' | sudo tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
  echo 'options nouveau modeset=0' | sudo tee /etc/modprobe.d/nouveau-kms.conf

    sudo sed -i 's/\#    "\/dev\/nvidiactl", "\/dev\/nvidia0", "\/dev\/nvidia-modeset",/\    "\/dev\/nvidiactl", "\/dev\/nvidia0", "\/dev\/nvidia-modeset",/g' /etc/libvirt/qemu.conf

    # grubgpu="nouveau.modeset=0 nvidia-drm.modeset=1"
    sleep 1s
# elif lspci -nn | egrep -i "3d|display|vga" | grep -iq 'amd'; then
#     grubgpu="amdgpu.aspm=0"
#     sleep 1s
fi

sudo mkdir -p /etc/libvirt/hooks

echo 'Xcursor.theme: Catppuccin-Mocha-Mauve-Cursors' | tee -a "$HOME"/.Xresources
echo 'Xcursor.size: 48' | tee -a "$HOME"/.Xresources

echo 'xset r rate 300 60' | tee -a "$HOME"/.xinitrc
echo 'xrdb ~/.Xresources' | tee -a "$HOME"/.xinitrc

# echo 'XCURSOR_THEME=Catppuccin-Mocha-Mauve-Cursors' | sudo tee -a /etc/environment
# echo 'XCURSOR_SIZE=48' | sudo tee -a /etc/environment
# echo 'QT_STYLE_OVERRIDE=kvantum' | sudo tee -a /etc/environment
# echo 'DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1' | sudo tee -a /etc/environment
echo 'DOTNET_CLI_TELEMETRY_OPTOUT=1' | sudo tee -a /etc/environment
echo 'DOTNET_ROOT=$HOME/.dotnet' | sudo tee -a /etc/environment
echo 'PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' | sudo tee -a /etc/environment
echo 'FrameworkPathOverride=/lib/mono/4.8-api' | sudo tee -a /etc/environment
# echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json' | sudo tee -a /etc/environment
# echo 'VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d' | sudo tee -a /etc/environment
# echo 'XDG_CONFIG_HOME=$HOME/.config' | sudo tee -a /etc/environment
# echo 'XDG_SCREENSHOT_DIR=$HOME/Pictures/Grim' | sudo tee -a /etc/environment
# echo 'XDG_DATA_DIRS=/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS' | sudo tee -a /etc/environment

# sudo sed -i 's/QT_QPA_PLATFORMTHEME/# QT_QPA_PLATFORMTHEME/g' /etc/environment
# sudo sed -i 's/GTK_THEME.*/GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark/g' /etc/environment
#
# echo 'QT_QPA_PLATFORMTHEME=qt5ct:qt6ct' | sudo tee -a /etc/environment

sudo sed -i 's/vboxpci//g' /usr/lib/modules-load.d/virtualbox.conf

sync
sleep 1s

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
echo 'Installing HeadsetControl'
echo
cd "$HOME"/dotfiles/apps/HeadsetControl
mkdir build && cd build
cmake ..
sync
make
sync
sudo make install
sync
sudo udevadm control --reload-rules && sudo udevadm trigger
cd ..
echo
echo 'Removing leftover'
echo
rm -rf build
sync
cd "$HOME"/dotfiles

echo
echo 'Installing HeadsetControl Notification daemon'
echo
sudo cp "$HOME"/dotfiles/apps/headsetcontrol-notificationd/headsetcontrol-notificationd.service /etc/systemd/user/
sudo cp "$HOME"/dotfiles/apps/headsetcontrol-notificationd/headsetcontrol-notificationd /usr/local/bin/
sudo chmod +x /usr/local/bin/headsetcontrol-notificationd
sudo systemctl daemon-reload
systemctl --user enable --now headsetcontrol-notificationd
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
echo "Set make to be multi-threaded by default"
echo
sudo sed -i "s|\#MAKEFLAGS=.*|MAKEFLAGS=\"-j$(expr "$(nproc)" \+ 1)\"|g" /etc/makepkg.conf
sync
sudo sed -i "s|COMPRESSXZ=.*|COMPRESSXZ=(xz -c -T $(expr "$(nproc)" \+ 1) -z -)|g" /etc/makepkg.conf
sync
sleep 1s

# Enabling autologin
sudo sed -i "0,/\[Autologin\]/s//\[Autologin\]\nUser\=$(logname)/" /etc/sddm.conf
sync

echo
echo "Setting up fq_pie queue discipline for TCP congestion control"
echo
echo 'net.core.default_qdisc = fq_pie' | sudo tee /etc/sysctl.d/90-override.conf
sync
sleep 1s

echo
echo "Amending journald Logging to 200M"
echo
sudo sed -i "s|#SystemMaxUse=.*|SystemMaxUse=200M|g" /etc/systemd/journald.conf
sync
sleep 1s

echo
echo "Restricting Kernel Log Access"
echo
sudo sysctl -w kernel.dmesg_restrict=1
sleep 1s

if ! [ -f /etc/sysctl.d/99-sysctl.conf ]; then
  sudo touch /etc/sysctl.d/99-sysctl.conf
  sync
fi

echo
echo "Increasing file watcher count. This prevents a \"too many files\" error in VS Code(ium)"
echo
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf
sync
sleep 1s

echo 'fs.inotify.max_user_instances=8192' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'vm.max_map_count=524288' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'net.core.rmem_max=5242880' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'net.core.wmem_max=5242880' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.sched_cfs_bandwidth_slice_us=3000' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.core_pattern=|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.core_pipe_limit=16' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'fs.suid_dumpable=2' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.sysrq=16' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.core_uses_pid=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'net.core.default_qdisc=fq_codel' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'fs.protected_hardlinks=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'fs.protected_symlinks=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'fs.protected_regular=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'fs.protected_fifos=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.pid_max=4194304' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'fs.aio-max-nr=1048576' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'vm.unprivileged_userfaultfd=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'vm.swappiness=133' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.nmi_watchdog=0' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.unprivileged_userns_clone=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.printk=3 3 3 3' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.sysrq=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
sync
sudo sysctl --system
sleep 1s

echo
echo "Increasing open file limit"
echo
sudo sed -i "s|# End of file.*|$(logname)        hard    nofile          2097152\n\n# End of file\n|g" /etc/security/limits.conf
sudo sed -i "s|# End of file.*|$(logname)        soft    nofile          1048576\n\n# End of file\n|g" /etc/security/limits.conf
sudo sed -i "s|#DefaultLimitNOFILE=.*|DefaultLimitNOFILE=2097152|g" /etc/systemd/system.conf
sudo sed -i "s|#DefaultLimitNOFILE=.*|DefaultLimitNOFILE=1048576|g" /etc/systemd/user.conf
sync
sleep 1s

echo
echo "Disabling built-in kernel modules of tablet so OpenTablerDriver can work"
echo
if ! test -e /etc/modprobe.d/blacklist.conf; then
    sudo touch /etc/modprobe.d/blacklist.conf
    printf "blacklist wacom\nblacklist hid_uclogic" | sudo tee /etc/modprobe.d/blacklist.conf
else
    printf "\nblacklist wacom\nblacklist hid_uclogic" | sudo tee -a /etc/modprobe.d/blacklist.conf
fi
sync
sleep 1s

echo
echo "Stopping Wacom kernel module (if present)"
echo
sudo rmmod wacom
sleep 1s

echo
echo "Stopping non-Wacom kernel module (if present)"
echo
sudo rmmod hid_uclogic
sleep 1s

echo
echo "Creating udev rule for AntiMicroX to avoid problems with wayland"
echo
if test -e /usr/lib/udev/rules.d/60-antimicrox-uinput.rules; then
    sudo mv /usr/lib/udev/rules.d/60-antimicrox-uinput.rules /usr/lib/udev/rules.d/60-antimicrox-uinput.rules.old
    sync
fi
sudo touch /usr/lib/udev/rules.d/60-antimicrox-uinput.rules
sync

curl https://raw.githubusercontent.com/AntiMicroX/antimicrox/master/other/60-antimicrox-uinput.rules -o - | sudo tee /usr/lib/udev/rules.d/60-antimicrox-uinput.rules
sleep 1s

# Enable services
systemctl --user enable pipewire-pulse.service
sudo systemctl enable fstrim.timer
sudo systemctl enable sshd.service
sudo systemctl enable btrfs-scrub@-.timer
sudo systemctl enable btrfs-scrub@home.timer
sudo systemctl daemon-reload
sleep 1s

cd "$HOME"/dotfiles/apps/hdrop
sudo make install
sync
sleep 1s
sudo make install
sync
sleep 1s

if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
    # Using this at hyprland.conf
    # if ! grep -iq "VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json" /etc/environment; then
    #     echo
    #     echo "Assigning \"VK_ICD_FILENAMES\" to \"nvidia_icd.json\""
    #     echo
    #     echo "VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json" | sudo tee -a /etc/environment
    # sleep 1s
    # fi
    echo
    echo "Removing vulkan for non-NVidia GPUs to avoid conflicts"
    echo
    sudo pacman -Rsn lib32-vulkan-radeon vulkan-radeon lib32-vulkan-intel vulkan-amdgpu-pro amf-amdgpu-pro --noconfirm
    sleep 1s
fi

# Using this at hyprland.conf
# if ! grep -iq "VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d" /etc/environment; then
#     echo
#     echo "Assigning \"VK_LAYER_PATH\" to \"explicit_layer.d\""
#     echo
#     echo "VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d" | sudo tee -a /etc/environment
#     sleep 1s
# fi

make -C "$HOME"/dotfiles/apps/ble.sh install PREFIX="$HOME"/.local

rm -rf nohup.out

modprobed-db

sed -i 's/IGNORE/# IGNORE/g' "$HOME"/.config/modprobed-db.conf

modprobed-db store

# These can prevent some programs from starting. Let's comment them
sudo sed -i 's/export GDK_BACKEND/# export GDK_BACKEND/g' /usr/local/bin/hyprstart
sudo sed -i 's/export SDL_VIDEODRIVER/# export SDL_VIDEODRIVER/g' /usr/local/bin/hyprstart
sudo sed -i 's/export CLUTTER_BACKEND/# export CLUTTER_BACKEND/g' /usr/local/bin/hyprstart

# We'll use qt5ct:qt6ct so let's comment it to avoid any "fun" stuff
# sudo sed -i 's/export QT_QPA_PLATFORMTHEME/# export QT_QPA_PLATFORMTHEME/g' /usr/local/bin/hyprstart

sudo sed -i 's/#UserspaceHID=.*/UserspaceHID=true/g' /etc/bluetooth/input.conf

sudo cp -r "$HOME"/dotfiles/apps/CRT-Amber-GRUB-Theme /boot/grub/themes/
sudo sed -i "s/GRUB_THEME.*/GRUB_THEME=\"\/boot\/grub\/themes\/CRT-Amber-GRUB-Theme\/theme.txt\"/g" /etc/default/grub

GRUB=`cat /etc/default/grub | grep "GRUB_CMDLINE_LINUX_DEFAULT" | rev | cut -c 2- | rev`

# if sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o amd; then
#     GRUB+=" amd_iommu=on iommu=pt kvm_amd.npt=1 kvm_amd.avic=1 kvm_amd.nested=1 kvm_amd.sev=1 kvm.ignore_msrs=1 kvm.report_ignored_msrs=0 video=vesafb:off,efifb:off,simplefb:off$grubgpu systemd.unified_cgroup_hierarchy=0\""
#     sleep 1s
# elif sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o intel; then
#     GRUB+=" intel_iommu=on iommu=pt kvm.ignore_msrs=1 kvm.report_ignored_msrs=0 video=vesafb:off,efifb:off,simplefb:off$grubgpu systemd.unified_cgroup_hierarchy=0\""
#     sleep 1s
# fi

if sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o amd; then
    GRUB+=" iommu=pt $grubgpu\""
    sleep 1s
elif sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o intel; then
    GRUB+=" intel_iommu=on iommu=pt $grubgpu\""
    sleep 1s
fi

sudo sed -ie "s|^GRUB_CMDLINE_LINUX_DEFAULT.*|${GRUB}|g" /etc/default/grub
sleep 1s

echo
echo "Enabling nested kvm"
echo

if ! [[ -d /etc/modprobe.d ]]; then
    echo
    echo "Creating \"/etc/modprobe.d\" folder"
    echo
    sudo mkdir -p /etc/modprobe.d
    sleep 1s
fi

if sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o amd; then
    if ! [[ -f /etc/modprobe.d/kvm.conf ]]; then
        sudo touch /etc/modprobe.d/kvm.conf
        sleep 1s
    fi

    printf "options kvm_amd nested=1\noptions kvm ignore_msrs=1\noptions kvm report_ignored_msrs=0\n" | sudo tee /etc/modprobe.d/kvm.conf
    sudo modprobe -r kvm-amd
    sudo modprobe kvm-amd
    sleep 1s
elif sudo grep 'vendor' /proc/cpuinfo | uniq | grep -i -o intel; then
    if ! [[ -f /etc/modprobe.d/kvm.conf ]]; then
        sudo touch /etc/modprobe.d/kvm.conf
        sleep 1s
    fi

    printf "options kvm-intel nested=1\noptions kvm ignore_msrs=1\noptions kvm report_ignored_msrs=0\noptions kvm-intel enable_shadow_vmcs=1\noptions kvm-intel enable_apicv=1\noptions kvm-intel ept=1\n" | sudo tee /etc/modprobe.d/kvm.conf
    sudo modprobe -r kvm-intel
    sudo modprobe kvm-intel
    sleep 1s
fi

if ! [[ -f /etc/dracut.conf.d/10-vfio.conf ]]; then
  sudo touch /etc/dracut.conf.d/10-vfio.conf
  sleep 1s
fi
echo 'force_drivers+=" vfio vfio_pci vfio_iommu_type1 "' | sudo tee /etc/dracut.conf.d/10-vfio.conf

sudo dracut-rebuild

sudo modprobe vfio-pci
sudo modprobe vfio
sudo modprobe vfio-iommu-type1
# sudo modprobe vfio-virqfd
# sudo modprobe iommu_v2
# sudo modprobe iommufd
sleep 1s

echo 'blacklist iTCO_wdt' | sudo tee /etc/modprobe.d/nowatchdog.conf
echo 'net.ipv4.conf.all.arp_filter = 1' | sudo tee /etc/sysctl.d/30-arpflux.conf
sleep 1s

sudo update-grub

echo
echo "You must run both qt5ct and qt6ct and adjust their themes, icons, etc accordingly"
echo
echo "Run otd-gui to configure your non-wacom Tablet"
echo
echo "Run crontab -e and place the following in there:"
echo '0 */1 * * *   /usr/bin/modprobed-db store &> /dev/null'
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
