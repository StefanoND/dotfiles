#!/usr/bin/env bash

HOMEPATH="$HOME"

if ! [ "$EUID" -ne 0 ]; then
  echo
  echo "Don't run this script as root."
  echo
  sleep 1s
  exit 1
fi

if ! [ -d "$HOMEPATHPATH"/dotfiles ]; then
  echo
  echo "Could not find $HOMEPATH\/dotfiles"
  echo
  exit 2
fi

rootpath=$HOMEPATH/dotfiles
cpath=$PWD

mkdir "$HOMEPATH"/.apps
mkdir -p "$HOMEPATH"/.cache/ccls
mkdir -p "$HOMEPATH"/.config/atuin

ln -svf "$rootpath"/.config/tmux "$HOMEPATH"/.config/
ln -svf "$rootpath"/.config/atuin/config.toml "$HOMEPATH"/.config/atuin
ln -svf "$rootpath"/.config/bat "$HOMEPATH"/.config/
ln -svf "$rootpath"/.config/fish "$HOMEPATH"/.config/
ln -svf "$rootpath"/.config/fish/config.fish "$HOMEPATH"/.fishrc.fish
ln -svf "$rootpath"/.config/fish/abbreviations.fish "$HOMEPATH"/.abbreviations.fish
ln -svf "$rootpath"/.config/kitty "$HOMEPATH"/.config/
ln -svf "$rootpath"/.config/spotify-player "$HOMEPATH"/.config/
ln -svf "$rootpath"/.config/nasher "$HOMEPATH"/.config/

ln -svf "$rootpath"/.config/brave-flags.conf "$HOMEPATH"/.config/
ln -svf "$rootpath"/.config/waybar "$HOMEPATH"/.config/
ln -svf "$rootpath"/.config/rofi "$HOMEPATH"/.config/
ln -svf "$rootpath"/.local/share/rofi "$HOMEPATH"/.local/share/

mkdir -p "$HOMEPATH"/.local/share/dbus-1/services

cp "$rootpath"/.local/share/dbus-1/services/org.freedesktop.secrets.service "$HOMEPATH"/.local/share/dbus-1/services/

sudo pacman -Rsn rar --unneeded --noconfirm

# PACMAN
PKGS=(
  # Dev
  'rustup'              # Rust Programming Language
  'cmake'               # CMake Software Builder
  'cmake-extras'        # CMake Addons
  'extra-cmake-modules' # Extra Modules and Scripts for CMake
  'python3'             # Python programming Language
  'python-pip'          # Package Manager for Python
  'python-pipx'         #
  'python-argcomplete'  #
  'clang'               # C family goodie
  'ccls'                #
  'automake'
  'libtool'
  'premake'
  'bear'
  'lldb'
  'gdb'
  'doxygen'
  'texlive-bin'
  'texlive-latexrecommended'
  'texlive-latexextra'
  'mariadb'

  # Godot
  'godot-mono' # Godot Game Engine with C# support

  # Unreal Engine
  # Just download from the website
  # https://www.unrealengine.com/en-US/linux
  # https://neunerdhausen.de/posts/unreal-engine-5-with-vim/

  # Unity
  'android-udev' # udev rules for android

  # C Sharp
  'dotnet-sdk'                #
  'dotnet-sdk-6.0'            #
  'dotnet-sdk-7.0'            #
  'dotnet-sdk-8.0'            #
  'aspnet-runtime'            #
  'aspnet-runtime-6.0'        #
  'aspnet-runtime-7.0'        #
  'aspnet-runtime-8.0'        #
  'dotnet-targeting-pack'     #
  'dotnet-targeting-pack-6.0' #
  'dotnet-targeting-pack-7.0' #
  'dotnet-targeting-pack-8.0' #
  'aspnet-targeting-pack'     #
  'aspnet-targeting-pack-6.0' #
  'aspnet-targeting-pack-7.0' #
  'aspnet-targeting-pack-8.0' #
  'mono'                      #
  'mono-msbuild'              #
  'mono-msbuild-sdkresolver'  #
  'libuv'                     #

  # Terminal
  'kitty'                   # Terminal Emulator with GPU Acceleration
  'kitty-shell-integration' # Better integration with bash, zsh and find
  'kitty-terminfo'          # Better Terminfo for Kitty
  'tmux'                    # Terminal multiplexer
  'wl-clipboard'            # Wayland clipboard for tmux
  'starship'                # Fast shell prompt
  'yazi'                    # TUI File Manager
  'atuin'
  'fish'

  # Fonts
  'inter-font'              # Industry standard general font
  'ttf-jetbrains-mono'      # Industry standard programming font
  'ttf-jetbrains-mono-nerd' # Same as above for ricing
  'powerline-fonts'         # Ricing fonts
  'noto-fonts'              # Open-Source "universal" fonts
  'noto-fonts-extra'        # Extra variations to noto fonts such as condensed, semi-bold, etc
  'noto-fonts-cjk'          # Support port Chinese Janapese and Korean characters
  'noto-fonts-emoji'        # Emoji Support

  # Ble.sh Dependencies
  'thefuck'   #
  'zoxide'    # Better "cd"
  'ugrep'     # Better "grep"
  'fastfetch' # Better "fetch"

  # CLI
  'fd'  # Fast Find
  'fzf' # Fuzzy Finder
  'eza' # Better "ls"
  'bat' # Better "cat"

  # File Manager (GUI)
  'archlinux-xdg-menu'       #
  'dolphin'                  # File Manager
  'dolphin-plugins'          # Git, Mercurial and Dropbox support
  'kompare'                  # Adds 'Compare Files' dialog
  'kdegraphics-thumbnailers' # File preview support for Image, PDFs and Blender files
  'kimageformats'            # File preview support for Gimp's .xcf files
  'kimageformats5'           # File preview support for Gimp's .xcf files
  'libheif'                  # File preview support for Gimp's .heic files
  'jxrlib'                   # File preview support for jpegxr .jxr files
  'qt5-imageformats'         # File preview support for .webp, .tiff, .tga and .jp2 files
  'qt6-imageformats'         # File preview support for .webp, .tiff, .tga and .jp2 files
  'ffmpegthumbs'             # File preview support for Video Files (based on ffmpeg)
  'kdesdk-thumbnailers'      # Plugins for the thumbnailing system
  'taglib'                   # Audio files
  'icoutils'                 # Extracts/Convers from/to M$ icon and cursor files (also adds file preview support for .ico, .cur and embedded .exe files)

  # KDE
  'gwenview'         # Photo Viewer
  'partitionmanager' # Partition Manager

  # Media
  'gimp'             # Image Manipulation Tools
  'gimp-nufraw'      # Raw support
  'gimp-plugin-gmic' # g'mic support

  # Git
  'git-delta' # Colorized Git Diffs
  'ghq'       # Manage remote repo clones

  # Misc
  'brave-bin'           # Browser
  'realtime-privileges' # Useful for pipewire
  'mullvad-vpn'         # Least worst VPN
  'compress'            # (De)Compress from/to .Z files
  '7zip'                # (De)Compress from/to .7z files
  'v4l2loopback-dkms'
  'imagemagick'
  'lazygit'
  'peco'

  # Keyring and Portals
  # 'kwallet'                     # KDE Keyring solution
  # 'kwallet5'                    # KDE Keyring solution (QT5)
  # 'kwalletmanager'              # Keyring manager (GUI)
  # 'kwallet-pam'                 # KDE Keyring solution
  'pam'
  'libgnome-keyring'            # Deprecated but required by some apps (Superseded by libsecret)
  'libsecret'                   #
  'gnome-keyring'               # GNOME Keyring solution
  'seahorse'                    #
  'xdg-desktop-portal'          # Desktop API
  'xdg-desktop-portal-gtk'      # Desktop API (GTK)
  'xdg-desktop-portal-hyprland' # Desktop API (Hyprland)
  'xdg-desktop-portal-kde'      # Desktop API (KDE/QT)

  # VM
  # 'qemu-full'
  'qemu-desktop'  # "Machine emulator and virtualizer"
  'libvirt'       # VM Manager tool
  'virt-manager'  # GUI for libvirt/QEMU
  'virt-viewer'   # "Simple remote display client"
  'virt-firmware' # Tool for managing VMs' firmware
  'edk2-ovmf'     # UEFI support for VMs
  'vde2'          # Virtual Distributed Ethernet
  'dmidecode'     # DMI System Info support
  'dnsmasq'       # NAT/DHCP networking
  # 'bridge-utils'              # Ethernet brigding tool (DEPRECATED use "bridge" from iproute2)
  'iproute2'       # Collection of utilities for controlling TCP/IP (replacing bridge-utils)
  'openbsd-netcat' # For management over SSH
  # 'ebtables'                  # DEPRECATED use nftables
  # 'iptables-nft'              # DEPRECATED use nftables
  'nftables'   # "Firewall, NAT and packet mangling for linux"
  'libguestfs' # Library for managing VMs' disk images
  'swtpm'      # TPM emulator for VMs

  # Since I'm mostly a game dev I need some game dependencies
  # I'm following this guide
  # https://wiki.cachyos.org/configuration/gaming/
  # It takes care of Wine dependency hell, installs Wine Steam, Winetricks and Protontricks
  # It also adds support for Proton on Wayland (proton-cachyos), must be used with steam-native-runtime
  # You might want to add "LD_PRELOAD="" %command%" to all games' launch options, unless told otherwise
  #   This fixes sturreting caused by the Steam Game Recorder feature
  # If you built your own kernel with any sched-ext:
  #   Disable ananicy-cpp and DON'T use Feral's Gamemode
  #   I don't recommend manually messing with power profile related stuff (this includes their game-performance script)
  'cachyos-gaming-meta'
  'lutris'
  'umu-launcher'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | sudo pacman -S "$PKG" --needed
  sync
done

systemctl --user enable --now gnome-keyring-daemon
systemctl --user enable --now gcr-ssh-agent.socket

sudo systemctl restart systemd-binfmt

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
sync

# fish -c "fisher install jorgebucaran/nvm.fish"
# fish -c "fisher install IlanCosman/tide@v6"
fish -c "fisher install jethrokuan/z"
fish -c "fisher install PatrickF1/fzf.fish"
fish -c "fisher install jorgebucaran/nvm.fish"
register-python-argcomplete --shell fish pipx >~/.config/fish/completions/pipx.fish

sudo pacman -Rsn obs-studio --noconfirm --unneeded

mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

sudo systemctl enable --now mariadb

if ! [ -d /etc/my.cnf.d ]; then
  sudo mkdir /etc/my.cnf.d
fi

if ! [ -f /etc/my.cnf.d/server.cnf ]; then
  sudo touch /etc/my.cnf.d/server.cnf
fi

printf "\n[mariadb]\nbind-address = localhost\nskip-networking\n" | sudo tee -a /etc/my.cnf.d/server.cnf

sudo systemctl restart mariadb

rustup install stable
sync

rustup target install i686-unknown-linux-gnu
sync

rustup default stable
sync

cargo install async-cmd
sync

echo
echo "Setting yazi as paru's File Manager"
echo
sudo sed -i "s|\#\[bin]|[bin]|g" /etc/paru.conf
sudo sed -i "s|#FileManager.*|FileManager = yazi|g" /etc/paru.conf
sync

sudo sed -ie "/-auth.*pam_gnome_keyring.so/s/^.//g" /etc/pam.d/sddm
sudo sed -ie "/-password.*pam_gnome_keyring.so/s/^.//g" /etc/pam.d/sddm
sudo sed -ie "/-session.*pam_gnome_keyring.so/s/^.//g" /etc/pam.d/sddm
printf "password	optional	pam_gnome_keyring.so\n" | sudo tee -a /etc/pam.d/passwd

if ! grep -i 'hyprland' /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal; then
  sudo sed -ie "/UseIn=gnome/s/$/;hyprland/g" /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal
fi

# PARU
PKGPARU=(
  # Epic Games/Unreal Engine
  # go to: https://www.epicgames.com/ and it'll automatically ask to accept EULA
  'eam-git'

  # Unity
  'unityhub'
  'android-sdk'

  'vesktop'             # Open-Source Discord
  'spotify-player-full' # Open-Source Spotify

  # Terminal
  'find-the-command-git' # When command you typed doesn't exits, it'll try to install it
  'blesh-git'

  # File Manager
  'resvg'               # Fast and Accurate preview of SVG images
  'raw-thumbnailer'     # File preview support for .raw files
  'kde-thumbnailer-apk' # File preview support for Android Package files

  # NWScript
  'choosenim'

  # Misc
  'archlinux-tweak-tool-git'
  'driverctl' # Device driver control utility
  'rar'       # Rar AND Unrar

  # OBS Studio
  'obs-studio-git'
)

for PKG in "${PKGPARU[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  paru -S "$PKG" --noconfirm --needed --sudoloop
  sync
done

export PATH="$HOMEPATH/.nimble/bin:$PATH"

choosenim stable

nimble install nasher

# PIP
PKGPIP=(
  'pynvim'
  'gdtoolkit'
  'grip'

  # CMake
  'cmake-language-server' # CMake LSP
  # Unreal Engine
  'ue4cli' # Wrapper for UnrealBuildTool

  # NWScript
  'rollnw'
  'arclight' # NWScript LSP
)

for PKG in "${PKGPIP[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  CC=cc python -m pip install --user --upgrade --break-system-packages "$PKG"
  sync
done

# Baloo's KDE's file indexer and searcher. It's useless in hyprland
balooctl6 disable

if [ -f /usr/share/applications/mimeinfo.cache ]; then
  sudo sed -i 's/inode\/directory=.*/inode\/directory=org.kde.dolphin.desktop;/g' /usr/share/applications/mimeinfo.cache
fi

if ! [ -f "$HOMEPATH"/.config/mimeapps.list ]; then
  printf "[Default Applications]\ninode\/directory=org.kde.dolphin.desktop\n" >"$HOMEPATH"/.config/mimeapps.list
else
  sudo -i 's/inode\/directory=.*/inode\/directory=org.kde.dolphin.desktop/g' "$HOMEPATH"/.config/mimeapps.list
fi

if ! xdg-mime query default inode/directory | grep -iq "dolphin"; then
  xdg-mime default org.kde.dolphin.desktop inode/directory
fi

XDG_MENU_PREFIX=arch- kbuildsycoca6

ln -svf "$rootpath"/.config/starship.toml "$HOMEPATH"/.config/
ln -svf "$rootpath"/.bashrc "$HOMEPATH"/
ln -svf "$rootpath"/.bash_aliases "$HOMEPATH"/
ln -svf "$rootpath"/.profile "$HOMEPATH"/
ln -svf "$rootpath"/.gitconfig "$HOMEPATH"/
ln -svf "$rootpath"/.editorconfig "$HOMEPATH"/

echo
echo "Login to mullvad"
echo
mullvad account login
sleep 1s

mullvad relay set location se # Sweden be cause "all VPNs there are owned by Mullvad" - Someone from internet
mullvad lan set allow         # Needed for VMs to access the internet
mullvad lockdown-mode set on
mullvad auto-connect set on
mullvad relay set tunnel-protocol wireguard # Wireguard is faster than OpenVPN - Someone from internet
mullvad reconnect

sudo gpasswd -a "$(logname)" realtime

sudo usermod -a -G video qemu

sudo usermod -a -G kvm,libvirt,libvirt-qemu,video "$(logname)"

sudo systemctl enable --now virtnetworkd

sudo systemctl enable --now virtqemud

sudo systemctl enable --now virtstoraged

sudo systemctl enable --now libvirtd

sudo gpasswd -M "$(logname)" kvm

sudo gpasswd -M "$(logname)" libvirt

sudo virsh net-autostart default

GPUPTPATH=$rootpath/GPUPT

sudo mv /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.old
sync

sudo cp "$GPUPTPATH"/config/libvirtd.conf /etc/libvirt/
sync

sudo mv /etc/libvirt/libvirt.conf /etc/libvirt/libvirt.conf.old
sync

sudo cp "$GPUPTPATH"/config/libvirt.conf /etc/libvirt/
sync

sudo mv /etc/libvirt/network.conf /etc/libvirt/network.conf.old
sync

sudo cp "$GPUPTPATH"/config/network.conf /etc/libvirt/
sync

sudo mv /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.old
sync

sudo cp "$GPUPTPATH"/config/qemu.conf /etc/libvirt/
sync

sudo ufw allow in on virbr0  # Needed for VMs to access the internet
sudo ufw allow out on virbr0 # Needed for VMs to access the internet
sudo ufw reload

if ! lspci | grep -i nvidia; then
  sudo sed -i "/nvidia/d" /etc/libvirt/qemu.conf
fi

if grep -qF "user=\"USERNAME\"" /etc/libvirt/qemu.conf; then
  echo
  echo "Adding \"$(logname)\" to qemu.conf's user"
  echo
  sudo sed -i "s|user=\"USERNAME\".*|user=\"$(logname)\"|g" /etc/libvirt/qemu.conf
  sleep 1s
fi

sudo mkdir -p /etc/libvirt/hooks/qemu.d && sudo wget 'https://asus-linux.org/files/vfio/libvirt_hooks/qemu' -O /etc/libvirt/hooks/qemu && sudo chmod +x /etc/libvirt/hooks/qemu
sync

sudo systemctl restart libvirtd

# Grep GPU's VGA ID
GPUVGAID="$(lspci -nn | grep -iE "0300" | grep -iE "nvidia" | grep -Eo "[[:xdigit:]]{4}:[[:xdigit:]]{4}")"
# Grep GPU's Audio ID
GPUAUDID="$(lspci -nn | grep -iE "0403" | grep -iE "nvidia" | grep -Eo "[[:xdigit:]]{4}:[[:xdigit:]]{4}")"

# Join GPU's VGA and Audio IDs together
GPUIDS="$GPUVGAID,$GPUAUDID"

# 10de:1b82,10de:10f0

GRUB="$(cat /etc/sdboot-manage.conf | grep "LINUX_OPTIONS" | rev | cut -c 2- | rev)"

echo "Safe: pcie_acs_override disabled"
GRUB+="nouveau.modeset=0 initcall_blacklist=acpi_cpufreq_init acpi_enforce_resources=lax amd_pstate.shared_mem=1 amd_pstate=active kvm_amd.avic=1 kvm_amd.force_avic=1 kvm_amd.nested=0 kvm_amd.sev=0 kvm_amd.npt=1 amd_iommu=on vfio_iommu_type1.allow_unsafe_interrupts=1 iommu=pt vfio-pci.ids=$GPUIDS rd.driver.pre=vfio-pci video=vesafb:off,efifb:off kvm.ignore_msrs=1 kvm.report_ignored_msrs=0 systemd.unified_cgroup_hierarchy=1\""

# cpufreq... not needed due to my custom kernel and sched-ext
# GRUB+="nouveau.modeset=0 cpufreq.default_governor=performance initcall_blacklist=acpi_cpufreq_init acpi_enforce_resources=lax amd_pstate.shared_mem=1 amd_pstate=active kvm_amd.avic=1 kvm_amd.force_avic=1 kvm_amd.nested=0 kvm_amd.sev=0 kvm_amd.npt=1 amd_iommu=on iommu=pt vfio_iommu_type1.allow_unsafe_interrupts=1 vfio-pci.ids=xxxx:xxxx,xxxx:xxxx rd.driver.pre=vfio-pci kvm.ignore_msrs=1 kvm.report_ignored_msrs=0 systemd.unified_cgroup_hierarchy=1\""

# echo "Unsafe: pcie_acs_override enabled"
# GRUB+="nouveau.modeset=0 cpufreq.default_governor=performance initcall_blacklist=acpi_cpufreq_init acpi_enforce_resources=lax amd_pstate.shared_mem=1 amd_pstate=active kvm_amd.avic=1 kvm_amd.force_avic=1 kvm_amd.nested=0 kvm_amd.sev=0 kvm_amd.npt=1 amd_iommu=on iommu=pt pcie_acs_override=downstream,multifunction vfio_iommu_type1.allow_unsafe_interrupts=1 vfio-pci.ids=xxxx:xxxx,xxxx:xxxx rd.driver.pre=vfio-pci kvm.ignore_msrs=1 kvm.report_ignored_msrs=0 systemd.unified_cgroup_hierarchy=1\""

sync

sudo sdboot-manage gen

printf "vfio vfio_iommu_type1 vfio_pci ids=%s\n" "$GPUIDS" | sudo tee /etc/modules-load.d/vfio-pci.conf
printf "options kvm_amd avic=1\noptions kvm_amd force_avic=1\noptions kvm_amd nested=0\noptions kvm_amd sev=0\noptions kvm_amd npt=1\n" | sudo tee /etc/modprobe.d/kvm-amd.conf
printf "options kvm ignore_msrs=1\noptions kvm report_ignored_msrs=0\n" | sudo tee /etc/modprobe.d/kvm.conf

printf "options vfio-pci ids=%s\n" "$GPUIDS" | sudo tee /etc/modprobe.d/vfio-pci.conf
printf "softdep nouveau pre: vfio_pci\nsoftdep nvidia pre: vfio_pci\nsoftdep nvidia* pre: vfio_pci\n" | sudo tee /etc/modprobe.d/nvidia.conf
printf "blacklist nouveau\noptions nouveau modeset=0\n" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
sync
sudo modprobe -r vfio-pci
sudo modprobe -r nvidia
sudo modprobe -r blacklist-nouveau
sudo modprobe -r kvm
sudo modprobe -r kvm-amd
sudo modprobe vfio-pci
sudo modprobe nvidia
sudo modprobe blacklist-nouveau
sudo modprobe kvm
sudo modprobe kvm-amd

MKINITCPIOMOD="$(cat /etc/mkinitcpio.conf | grep "MODULES" | rev | cut -c 2- | rev)"
MKINITCPIOMOD+=" pci_stub vfio_pci vfio vfio_iommu_type1 kvm kvm_amd)"
sync

if ! grep -iEq "modconf" /etc/mkinitcpio.conf; then
  MKINITCPIOHOOK="$(cat /etc/mkinitcpio.conf | grep "MODULES" | rev | cut -c 2- | rev)"
  MKINITCPIOHOOK+=" modconf)"
fi

sudo mkinitcpio -P
sync

VGACTL="$(lspci | grep -i 'vga compatible controller' | grep -i 'nvidia' | grep -Eo '[[:xdigit:]]{2}:[[:xdigit:]]{2}.[[:xdigit:]]{1}')"
AUDDEV="$(lspci | grep -i 'audio device' | grep -i 'nvidia' | grep -Eo '[[:xdigit:]]{2}:[[:xdigit:]]{2}.[[:xdigit:]]{1}')"

NORMVGACTL="0000:$VGACTL"
NORMAUDDEV="0000:$AUDDEV"

sudo driverctl set-override "$NORMVGACTL" vfio-pci
sudo driverctl set-override "$NORMAUDDEV" vfio-pci

sudo systemctl daemon-reload
sudo systemctl restart systemd-udevd.service
sudo systemctl restart libvirtd

sed -i "s|#USE_OVERLAYFS.*|USE_OVERLAYFS="yes"|g" "$HOMEPATH"/.config/psd/psd.conf
systemctl --user restart psd

chsh -s /usr/bin/fish

echo
printf "Must run visudo and add \"%s ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper\" at the END of the file" "$(logname)"
echo "You must restart psd after that: 'systemctl --user restart psd'"
echo
sleep 1s

echo
echo "Remove 'GDK_BACKEND', 'SDL_VIDEODRIVER', 'CLUTTER_BACKEND' from everywhere"
echo "either from environment variables or exports"
echo
sleep 1s

echo
echo "Run 'sudo mariadb-secure-installation' and follow instructions"
echo
sleep 1s

echo
echo "Done"
echo
exit 0
