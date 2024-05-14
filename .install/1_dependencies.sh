#!/bin/bash

if ! [ "$EUID" -ne 0 ]; then
  echo
  echo "Don't run this script as root."
  echo
  sleep 1s
  exit 1
fi

echo
echo 'Enabling Chaotic AUR Repo'
echo
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sleep 1s

sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
sleep 1s

sudo bash -c "echo '[chaotic-aur]' >> /etc/pacman.conf"
sudo bash -c "echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf"
sudo bash -c "echo '' >> /etc/pacman.conf"
sleep 1s

echo
echo "Adding Valve aur repo to the mirror list"
echo
sleep 1s
printf "[valveaur]\n" | sudo tee -a /etc/pacman.conf
sleep 1s
printf "SigLevel = Optional TrustedOnly\n" | sudo tee -a /etc/pacman.conf
sleep 1s
printf "Server = http://repo.steampowered.com/arch/valveaur\n" | sudo tee -a /etc/pacman.conf
sleep 2s
sudo pacman -Syy

echo
echo "Enabling Color and ILoveCandy"
echo
sleep 1s
sudo sed -i "s|#Color.*|Color\nILoveCandy|g" /etc/pacman.conf

sleep 1s

echo
echo "Updating mirrors with fast ones"
echo
sleep 1s
sudo pacman -S pacman-contrib --noconfirm --needed
sleep 1s
echo
echo "Downloading mirrors"
echo
sleep 1s

curl -o "$HOME/Downloads/mirrorlist" 'https://archlinux.org/mirrorlist/?country=AT&country=BE&country=FR&country=DE&country=IE&country=IT&country=LU&country=NL&country=PT&country=ES&country=CH&country=GB&country=US&protocol=https&ip_version=4'
sleep 1s
echo
echo "Uncomenting \"#Server\" from mirrorlist"
echo
sleep 1s
sed -i "s/#S/S/g" "$HOME/Downloads/mirrorlist"
sleep 1s
echo
echo "Ranking mirrors, this will take a while"
echo
sleep 1s
rankmirrors "$HOME/Downloads/mirrorlist" >"$HOME/Downloads/mirrorlist.fastest"
sleep 1s
echo
echo "Moving them to /etc/pacman.d/mirrorlist"
echo
sleep 1s
sudo mv -v /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
sleep 1s
sudo mv -v "$HOME/Downloads/mirrorlist.fastest" /etc/pacman.d/mirrorlist

sleep 1s

echo
echo "Updating system"
echo
sleep 1s
sudo pacman -Syyu --noconfirm --needed

if pacman -Q | grep -i 'iptables' && ! pacman -Q | grep -i 'iptables-nft'; then
  echo
  echo 'Uninstalling iptables'
  echo
  sudo pacman -Rdd iptables --noconfirm
  sleep 1s
fi

echo
echo 'Installing iptables-nft'
echo
sudo pacman -S iptables-nft --noconfirm --needed
sleep 1s

echo
echo "Installing meson as dependency"
echo
sudo pacman -S meson --asdep --noconfirm --needed
sleep 1s

if pacman -Q | grep -i 'rust' && ! pacman -Q | grep -i 'rustup'; then
  echo
  echo 'Uninstalling rust'
  echo
  sudo pacman -Rdd rust --noconfirm
  sleep 1s
fi

echo
echo "Installing rustup"
echo
sudo pacman -S rustup --noconfirm --needed
sleep 1s

PKGS=(
  # Tools
  'base-devel'       # Basic tools
  'meson'            # High productivity build system
  'mingw-w64'        # MinGW Cross-compiler pack (binutils, crt, gcc, headers and winpthreads)
  'libconfig'        # C/C++ Configuration file library
  'gdb'              # GNU Debugger
  'lldb'             # High performance debugger
  'qemu-guest-agent' # Helper Daemon

  # Kernel
  'dkms'              # Dynamic Kernel Modules System
  'linux-zen'         # Kernel and modules (ZEN)
  'linux-zen-headers' # Header files (ZEN)
  'linux-lts'         # Kernel and modules (LTS)
  'linux-lts-headers' # Header files (LTS)

  # Fonts
  'noto-fonts-extra'       # Additional variants of noto fonts
  'noto-fonts-cjk'         # Chinese Japanese Korean (CJK) characters support
  'noto-fonts-emoji'       # Support for emojis
  'ttf-fira-code'          # My personal favorite font for programming
  'gnu-free-fonts'         # Free family of scalable outline fonts
  'powerline-fonts'        # Patched fonts for powerline
  'ttf-ubuntu-font-family' # Ubuntu font

  # VM
  'qemu-full'
  'libvirt'
  'virt-manager'
  'edk2-ovmf'

  # Compression utilities
  'tar'
  'gzip'
  'bzip3'
  'unzip'
  'p7zip'
  'unrar'
  'zip'

  # Misc
  'cpupower' # CPU tuning utility
  'tuned'
  'zoxide'
  'fzf'
  'git-delta'
  'thefuck'
  'autojump'

  # WINE
  'alsa-lib'                    # Wine Dependency Hell
  'alsa-plugins'                # Wine Dependency Hell
  'dosbox'                      # Wine Dependency Hell
  'giflib'                      # Wine Dependency Hell
  'gnutls'                      # Wine Dependency Hell
  'gst-plugins-base-libs'       # Wine Dependency Hell
  'gtk3'                        # Wine Dependency Hell
  'lib32-alsa-lib'              # Wine Dependency Hell
  'lib32-alsa-plugins'          # Wine Dependency Hell
  'lib32-giflib'                # Wine Dependency Hell
  'lib32-gnutls'                # Wine Dependency Hell
  'lib32-gst-plugins-base-libs' # Wine Dependency Hell
  'lib32-gtk3'                  # Wine Dependency Hell
  'lib32-libjpeg-turbo'         # Wine Dependency Hell
  'lib32-libldap'               # Wine Dependency Hell
  'lib32-libpng'                # Wine Dependency Hell
  'lib32-libpulse'              # Wine Dependency Hell
  'lib32-libva'                 # Wine Dependency Hell
  'lib32-libxcomposite'         # Wine Dependency Hell
  'lib32-libxinerama'           # Wine Dependency Hell
  'lib32-libxslt'               # Wine Dependency Hell
  'lib32-mpg123'                # Wine Dependency Hell
  'lib32-ncurses'               # Wine Dependency Hell
  'lib32-openal'                # Wine Dependency Hell
  'lib32-opencl-icd-loader'     # Wine Dependency Hell
  'lib32-v4l-utils'             # Wine Dependency Hell
  'lib32-vulkan-icd-loader'     # Wine Dependency Hell
  'libjpeg-turbo'               # Wine Dependency Hell
  'libldap'                     # Wine Dependency Hell
  'libpng'                      # Wine Dependency Hell
  'libpulse'                    # Wine Dependency Hell
  'libva'                       # Wine Dependency Hell
  'libxcomposite'               # Wine Dependency Hell
  'libxinerama'                 # Wine Dependency Hell
  'libxslt'                     # Wine Dependency Hell
  'mpg123'                      # Wine Dependency Hell
  'ncurses'                     # Wine Dependency Hell
  'openal'                      # Wine Dependency Hell
  'opencl-icd-loader'           # Wine Dependency Hell
  'samba'                       # Wine Dependency Hell
  'v4l-utils'                   # Wine Dependency Hell
  'vulkan-icd-loader'           # Wine Dependency Hell
  'gst-plugins-bad'
  'gst-plugins-base'
  'gst-plugins-good'
  'gst-plugins-ugly'
  'lib32-acl'
  'lib32-attr'
  'lib32-gettext'
  'lib32-libnl'
  'lib32-libpcap'

  # 3D/Hardware Acceleration/Gaming related/dependencies
  'gstreamer'                  # Hardware Acceleration
  'gstreamer-vaapi'            # Hardware Acceleration
  'lib32-libappindicator-gtk2' # Tray Icon Support for Steam
  'lib32-libva-vdpau-driver'
  'lib32-sqlite' # Lutris Dependency
  'lib32-vkd3d'  #
  'libva-vdpau-driver'
  'libvdpau-va-gl'           # Hardware Acceleration
  'opencl-clhpp'             #
  'opencl-headers'           #
  'vkd3d'                    #
  'vulkan-headers'           # Vulkan Header Files
  'vulkan-tools'             # Vulkan Utilities and Tools
  'vulkan-validation-layers' # Vulkan Validation Layers

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

  # LSP
  'python-pip' # Required to install some LSP servers
  'npm'        # Required to install some LSp servers
  'yarn'       # Required to install some LSp servers
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
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  sudo pacman -S "$PKG" --noconfirm --needed
  echo
  sleep 1s
done

PKGT=(
  # LSP
  'cmake-language-server'
)

for PKG in "${PKGT[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  pip install "$PKG" --noconfirm --needed
  echo
  sleep 1s
done

PKGTS=(
  # LSP
  'vscode-langservers-extracted'
  'sql-language-server'
)

for PKG in "${PKGTS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  sudo npm i -g "$PKG"
  echo
  sleep 1s
done

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

dotnet tool install --global csharp-ls
sudo dotnet tool install --global csharp-ls

export PATH='$PATH:/root/.dotnet/tools'

sudo bash -c 'echo PATH="$PATH:/root/.dotnet/tools" >> /etc/environment'

sleep 1s

echo
echo 'Installing DOOM Emacs'
echo
git clone https://github.com/hlissner/doom-emacs "$HOME"/.emacs.d
"$HOME"/.emacs.d/bin/doom install

emacs
sleep 5s
sudo killall -9 emacs

"$HOME"/.emacs.d/bin/doom sync
sleep 1s

echo
echo 'Making xanmod-rt the default kernel to boot'
echo
sudo sed -i 's/default arch.conf/default arch-xanmod-rt.conf/g' /boot/loader/loader.conf
sleep 1s

echo
echo 'Updatin initramfs'
echo
sudo mkinitcpio -P
sleep 1s

echo
echo "Adding flathub"
echo
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sleep 1s

echo
echo "Setting CPU governor to Performance and setting min and max freq"
echo
sudo cpupower frequency-set -d 3.7GHz
sudo cpupower frequency-set -u 4.2GHz
sudo cpupower frequency-set -g performance
sleep 1s

echo
echo "Enabling cpupower service"
echo
sudo update-rc.d ondemand disable
sudo systemctl disable ondemand
sudo systemctl mask power-profiles-daemon.service
sudo systemctl enable --now cpupower.service
sleep 1s

echo
echo "Enabling tuned"
echo
sudo systemctl enable --now tuned.service
sleep 1s
sudo tuned-adm profile virtual-host
sleep 1s

echo
printf "Linking /usr/share/fonts to %s/.fonts" "$HOME"
echo
ln -svf /usr/share/fonts "$HOME"/.fonts

echo
echo "Installing stable version of Rustup"
echo
rustup install stable

echo
echo "Addidng i686 architecture support for Rustup"
echo
rustup target install i686-unknown-linux-gnu

echo
echo "Setting stable as our default Rustup toolchain"
echo
rustup default stable

echo
echo "Setting Cargo to run commands in parallel"
echo
cargo install async-cmd

echo
echo "Enabling btrfs's automatic balance at 10% threshold"
echo
sudo bash -c "echo 10 > /sys/fs/btrfs/$(sudo blkid -s UUID -o value /dev/mapper/root)/allocation/data/bg_reclaim_threshold"
sync
sleep 1s
sudo bash -c "echo 10 > /sys/fs/btrfs/$(sudo blkid -s UUID -o value /dev/mapper/home)/allocation/data/bg_reclaim_threshold"
sync
sleep 1s

exit 0
