#!/usr/bin/env bash
#
# Description of the script.

echo
echo "Adding Valve aur repo to the mirror list"
echo
sleep 1s
printf "[valveaur]\n" | sudo tee -a /etc/pacman.conf
sync
printf "Server = http://repo.steampowered.com/arch/valveaur\n" | sudo tee -a /etc/pacman.conf
sync

# Change pacman.conf
sudo sed -i "s/ParallelDownloads.*/ParallelDownloads = 20/g" /etc/pacman.conf
sync

sudo pacman -Syy

sudo pacman -Rsn thunar ttf-ms-fonts --noconfirm --unneeded

yes | sudo pacman -S wayland-protocols xdg-desktop-portal-hyprland wlr-randr

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
  'code'
  'swaync'                  # Notification

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
  'lttng-ust'
  'ncurses5-compat-libs'
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
  'archlinux-xdg-menu'
  'polkit'
  'polkit-kde-agent'
  'polkit-gnome'
  'gnome-themes-extra'
  'xwaylandvideobridge'
  'godot-mono'
  'linux-steam-integration'
  'vulkan-tools'
  'texlive-bin'
  'texlive-xetex'
  'texlive-luatex'
  'dvisvgm'
  'zotero-bin'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | sudo pacman -S "$PKG" --needed
  sync
  sleep 1s
done

if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
    echo
    echo "Removing vulkan for non-NVidia GPUs to avoid conflicts"
    echo
    PKGSRM=(
      'lib32-vulkan-radeon'
      'vulkan-radeon'
      'lib32-amdvlk'
      'amdvlk'
      'lib32-vulkan-amdgpu-pro'
      'vulkan-amdgpu-pro'
      'amf-amdgpu-pro'
      'lib32-vulkan-intel'
      'vulkan-intel'
      'lib32-vulkan-nouveau'
      'vulkan-nouveau'
      'lib32-vulkan-swrast'
      'vulkan-swrast'
      'swiftshader-git'
      'swiftshader'
    )

    for PKG in "${PKGSRM[@]}"; do
      echo
      echo "INSTALLING: ${PKG}"
      echo
      yes | sudo pacman -Rdd "$PKG" --unneeded
      sync
      sleep 1s
    done
fi

# PARU
PKGPARU=(
  'libicu53'                    # Required for Unreal Engine
  'opentabletdriver'            # Tablet Driver ("-git" version not working)
  'ttf-ms-win11-auto'           # Windows 11 fonts
  'wttrbar'                     # Weather for Waybar
)

for PKG in "${PKGPARU[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  paru -S "$PKG" --noconfirm --needed --sudoloop
  sync
  sleep 1s
done

echo
echo "Setting vifm as paru's File Manager"
echo
sudo sed -i "s|\#\[bin]|[bin]|g" /etc/paru.conf
sudo sed -i "s|#FileManager|FileManager|g" /etc/paru.conf
sync

fc-cache --force
fc-cache-32 --force
