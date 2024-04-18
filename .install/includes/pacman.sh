#!/bin/bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

ISKVM=n
CHECKKVM=$(sudo dmesg | grep "Hypervisor detected")

if [[ "$CHECKKVM" =~ "KVM" ]] ;then
  ISKVM=y
  echo
  echo "Virtual Machine Detected"
  echo
  sleep 1s
fi

PKGS=(
  # Hyprland
  'hyprland'                    # Hyprland
  'hyprpaper'                   # Wallpaper
  'xdg-desktop-portal-hyprland' # PolKit backend
  'waybar'                      # Status bar
  'dunst'                       #
  'cliphist'                    # Clipboard manager
  'hyprlock'                    # Lockscreen


  # Tools
  'rustup'                      # Rust toolchain
  'meson'                       # High productivity build system
  'mingw-w64'                   # MinGW Cross-compiler pack (binutils, crt, gcc, headers and winpthreads)
  'libconfig'                   # C/C++ Configuration file library
  'gdb'                         # GNU Debugger
  'lldb'                        # High performance debugger
  'bear'                        # C++ compilation database generator

  # Compression utilities
  'tar'
  'gzip'
  'bzip3'
  'unzip'
  'p7zip'
  'unrar'
  'zip'

  # Fonts
  'noto-fonts'                  #
  'otf-font-awesome'            #
  'ttf-firacode-nerd'           # My personal favorite font
  'ttf-fira-code'               #
  'ttf-fira-sans'               #
  'powerline-fonts'             # Patched fonts for powerline

  # Shell/Terminal
  'starship'                    # Terminal customizable prompt for shells
  'qalc'                        # Terminal Calculator

  # VM
  'qemu-full'                   #
  'libvirt'                     #
  'virt-manager'                #
  'edk2-ovmf'                   #

  # WINE
  'wine-staging'                # Compatibility Layer for running Windows programs (Staging Branch)
  'winetricks'                  # Work around problems and install apps under Wine
  'wine-mono'                   # Wine's built-in replacement for Microsoft's .NET Framework
  'wine-gecko'                  # Wine's built-in replacement for Microsoft's Internet Explorer
  'dos2unix'                    # Converting DOS stuff to unix

  # Misc
  'figlet'                      #
  'freerdp'                     # RDP Software
  'tumbler'                     # D-Bus thumbnailing service
  'papirus-icon-theme'          # Theme
  'flameshot'                   # Screenshot tool
  'ark'                         # (KDE) (Un)packer software
  'dolphin'                     # (KDE) File manager
  'dolphin-plugins'             # (KDE) Plugins for Dolphin
  'gwenview'                    # (KDE) Image viewer
  'kate'                        # (KDE) Text Editor
  'kleopatra'                   # (KDE) Document Viewer
  'kmix'                        # (KDE)
  'okular'                      # (KDE)
  'spectacle'                   # (KDE)
  'qalculate-qt'                # Calculator
  'guvcview-qt'                 # Interface for capturing and viewing video from (v4l2 devices) cameras
  'cpupower'                    # CPU tuning utility
  'btop'
    'jre17-openjdk'
    'jdk17-openjdk'
)

for PKG in "${PKGS[@]}"; do
    echo
    echo "INSTALLING: ${PKG}"
    echo
    sudo pacman -S "$PKG" --noconfirm --needed
    echo
    sleep 1s
done

if [[ "$ISKVM" = "y" ]] ;then
  echo
  echo "Installing QEMU Guest Agent"
  echo
  # Helper Daemon
  sudo pacman -S qemu-guest-agent --noconfirm --needed
  sleep 1s
fi

exit 0
