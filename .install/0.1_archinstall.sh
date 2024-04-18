#!/bin/bash

MYHOSTNAME="arch"
TIMEZONE="Europe/Lisbon"
USERNAME="archuser"
GROUPNAME="archuser"
SWAPSIZE="16G"
COUNTRIES="Germany,Portugal,Spain,France"
PROTOCOLS="https"
VALIDNIC=n
VALIDPARTTWO=n
ROOTPART=null
NICDEV=""
MAPPERROOT=""
UUIDROOTPART=""

lsblk
while [[ ${VALIDPARTTWO,,} = n ]]; do
    read -rp "Enter the name of the ROOT partition (eg. sda2, nvme0n1p2): " PARTTWO
    ROOTPART=$PARTTWO
    if lsblk | grep -w "$ROOTPART"; then
        VALIDPARTTWO=y
    else
        echo
        printf "Could not find /dev/%s, try again" "$ROOTPART"
        echo
    fi
done

while [[ ${VALIDNIC,,} = n ]]; do
    ip link
    read -rp "Enter the name of the NIC you want to enable dhcp (eg. enp0s3): " NICDEV
    if ip link | grep -w "$NICDEV"; then
        VALIDNIC=y
    else
        echo
        printf "Could not find %s, try again" "$NICDEV"
        echo
    fi
done

# Desktop Environment
PKGS=(
  'acpi'                    # Firmware interface for Hardware config and Power Management
  'acpi_call'               # Allow to call ACPI methods by passing parameters to /proc/acpi/call
  'acpid'                   # ACPI Daemon
  'avahi'                   # "Zeroconf" networking
  'bash-completion'         # Autocompletion for Bash
  'bat'                     # Better "ls"
  'bind'                    # Domain-name-to-IP conversion utility
  'blueman'                 # Bluetooth manager
  'bluez'                   # Bluetooth protocol stack
  'bluez-utils'             #
  'brightnessctl'           # Read and control device brightness
  'cups'                    # Printer Protocol
  'curl'                    # CLI for transfering data to/from a server using URLs
  'dhcpcd'                  # DHCP
  'dialog'                  # Dialog boxes for terminals
  'dosfstools'              # FAT filesystem utilities
  'eza'                     # "Better" eza (not eXa)
  'fastfetch'               # "Fast" neofetch
  'filelight'               # Show disk usage analyzer
  'flatpak'                 # Package Manager
  'gvfs'                    # Gnome Virtual Filesystem
  'hplip'                   # Driver for HP Deskjet (All-in-One) printers
  'ibus'                    # Input Method framework, for keyboards
  'inetutils'               # Collection of tools for operating on object files.
  'ipset'                   # Setup rules to IP addresses for firewall
  'kitty'                   # Terminal
  'man-pages'               # (Man)ual Pages, documentation "support" for packages
  'mtools'                  # Set of utilities for accessing MS-DOS disks from UNIX-like systems
  'nano'                    # Text Editor
  'network-manager-applet'  # NetworkManager System tray icon
  'networkmanager'          # NetworkManager
  'nfs-utils'               # NFS filesystem utilities
  'nm-connection-editor'    # NetworkManager GUI
  'nss-mdns'                # Name Service Switch, allows the system to resolve commong Unix/Linux programs
  'ntfs-3g'                 # NTFS support
  'ntp'                     # Network Time Protocol
  'openssh'                 # SSH
  'os-prober'               # Dual/Multi Boot tool
  'pacman-contrib'          # Scrips and tools for pacman systems
  'partitionmanager'        # Partitions Manager
  'polkit'                  # PolicyKit
  'polkit-kde-agent'        # (KDE) UI frontend for PolicyKit
  'qt5-wayland'             # QT5 Support
  'qt6-wayland'             # QT6 Support
  'reflector'               # Arch Linux mirrorlist manager
  'rsync'                   # File sync protocol and software
  'sed'                     # Stream Editor (text "manager")
  'skanlite'                # Image Scanning App (If you have a scanner or aio printer/scanner)
  'sof-firmware'            # Open Source Audio Firmware and SDK
  'tealdeer'                # Rust implementation of TLDR
  'terminus-font'           # Font
  'tmux'                    # Terminal Multiplexer
  'vifm'                    # Vim-like file manager
  'wget'                    # CLI utility for retrieving files
  # 'wpa_supplicant'          # Wifi stuff
  'xdg-desktop-portal'      # Grants access to sandboxed applications outside resources
  'xdg-user-dirs'           # Sets defaults user directories
  'xdg-utils'               # XDG utilities
  # 'xf86-video-amdgpu'       # Legacy X.org driver for AMDGPU
  # 'xf86-video-intel'        # Legacy X.org driver for Intel
  # 'xf86-video-nouveau'      # Legacy X.org driver for Nouveau (NVIDIA)
  # 'xf86-video-qxl'          # Legacy X.org driver for QXL (VM)
)

for PKG in "${PKGS[@]}"; do
    echo
    echo "INSTALLING: ${PKG}"
    echo
    sudo pacman -S "$PKG" --noconfirm --needed
    echo
    sleep 1s
done

# Set you system time
ln -sf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

# Generate /etc/adjtime
hwclock --systohc --utc

# Use fastest mirrors for our mirrorlist
reflector -c "$COUNTRIES" -p "$PROTOCOLS" -a 6 --sort rate --save /etc/pacman.d/mirrorlist

printf "\--save /etc/pacman.d/mirrorlist\n--country %s\n--protocol %s\n--age 6\n" "$COUNTRIES" "$PROTOCOLS" > /etc/xdg/reflector/reflector.conf

sed -i 's/\\--/--/g' /etc/xdg/reflector/reflector.conf

# Enable reflector timer
systemctl enable reflector.timer

# Update pacman repo cache
pacman -Syy
sleep 1s

# Add btrfs to modules
sed -i 's/MODULES=()/MODULES=(btrfs vfio vfio_pci vfio_iommu_type1 virtio-gpu virtio virtio_scsi virtio_blk virtio_pci virtio_net virtio_ring vmd qxl usbhid xhci_hcd btusb)/g' /etc/mkinitcpio.conf
sleep 1s

# Add btrfs and setfont to mkinitcpio's binaries
sed -i 's/BINARIES=()/BINARIES=(btrfs setfont)/g' /etc/mkinitcpio.conf
sleep 1s

# Add "btrfs" before "filesystems" and remove "fsck":
# HOOKS=(base udev autodetect modconf kms keyboard btrfs keymap encrypt consolefont block filesystems)
sed -i 's/HOOKS=(.*/HOOKS=(base udev autodetect modconf kms keyboard btrfs keymap consolefont plymouth block filesystems)/g' /etc/mkinitcpio.conf
# sed -i 's/HOOKS=(.*/HOOKS=(base udev autodetect modconf kms keyboard btrfs keymap encrypt consolefont plymouth block filesystems)/g' /etc/mkinitcpio.conf
sleep 1s

# Compress initramfs image
sed -i 's/#COMPRESSION="zstd"/COMPRESSION="zstd"/g' /etc/mkinitcpio.conf
sleep 1s

# Decompress kernel modules during initramfs creation (Speeds up boot process)
sed -i 's/#MODULES_DECOMPRESS=.*/MODULES_DECOMPRESS="yes"/g' /etc/mkinitcpio.conf
sleep 1s

# Create swapfile (Change size to your liking)
# We'll turn it on later
btrfs filesystem mkswapfile --size "$SWAPSIZE" --uuid clear /swap/swapfile
sleep 1s

# Create root password
echo
echo 'Root password'
echo
passwd

# Locale
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#en_US ISO-8859-1/en_US ISO-8859-1/g' /etc/locale.gen
sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#pt_BR ISO-8859-1/pt_BR ISO-8859-1/g' /etc/locale.gen
sed -i 's/#pt_PT.UTF-8 UTF-8/pt_PT.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#pt_PT ISO-8859-1/pt_PT ISO-8859-1/g' /etc/locale.gen
sleep 1s

# Generate locale
locale-gen
sleep 1s

# Set the system language and export it
echo LANG=en_US.UTF-8 > /etc/locale.conf
sleep 1s
export LANG=en_US.UTF-8

# Set keyboard layout permanent (optional)
echo KEYMAP=pt-latin1 > /etc/vconsole.conf
sleep 1s
export KEYMAP=pt-latin1

# Set hostname and localhost (change MYHOSTNAME to your liking at the top of this script)
printf "%s\n" "$MYHOSTNAME" > /etc/hostname
printf "127.0.0.1 localhost\n" >> /etc/hosts
printf "::1       localhost\n" >> /etc/hosts
printf "127.0.1.1 %s.localdomain %s\n" "$MYHOSTNAME" "$MYHOSTNAME" >> /etc/hosts
sleep 1s

# Change pacman.conf
sed -i "s/#Color/Color\nILoveCandy/g" /etc/pacman.conf
sed -i "s/#ParallelDownloads.*/ParallelDownloads = 15/g" /etc/pacman.conf
sed -i 's/\#\[multilib\]/[multilib]/g' /etc/pacman.conf
sed -i '/^\[multilib\]/a Include = \/etc\/pacman.d\/mirrorlist' /etc/pacman.conf
echo '' >> /etc/pacman.conf
sleep 1s

# Update pacman repo cache
pacman -Syy
sleep 1s

# Create a new group, rename GROUPNAME to your liking at the top of this script
groupadd "$GROUPNAME"
sleep 1s

# Creates new user, makes 'GROUPNAME' primary group and creates sys,...,storage groups
# Rename USERNAME to your liking at the top of this script
useradd -m -g "$GROUPNAME" -G sys,lp,kvm,network,power,storage -s /bin/bash "$USERNAME"
sleep 1s

# Let's do some stuff in the user account before adding password
sudo -u "$USERNAME" bash -c 'systemctl --user enable pipewire'
sudo -u "$USERNAME" bash -c 'systemctl --user enable pipewire-pulse'
sudo -u "$USERNAME" bash -c 'pulsemixer --create-config'
sudo -u "$USERNAME" bash -c 'kwriteconfig5 --file kdesurc --group super-user-command --key super-user-command sudo'
sleep 1s

# Give a password to it, rename USER to the one you set above
echo
printf "%s password" "$USERNAME"
echo
passwd "$USERNAME"

# Bootloader
# Make sure we have our efivars for installing the bootloader
mount -t efivarfs efivarfs /sys/firmware/efi/efivars/
sleep 1s

# Enable services
systemctl enable dhcpcd@"$NICDEV"
systemctl enable NetworkManager
systemctl enable fstrim.timer
systemctl enable cups.service
systemctl enable avahi-daemon
systemctl enable sshd
systemctl enable bluetooth
systemctl enable acpid
systemctl enable ntpd
systemctl enable systemd-timesyncd.service
systemctl enable btrfs-scrub@-.timer
systemctl enable btrfs-scrub@home.timer
systemctl start systemd-timesyncd.service
sleep 1s

# Install systemd-boot
bootctl --path=/boot install
sleep 1s

# Configure systemd-boot
printf "default arch.conf\ntimeout 2\nconsole-mode max\neditor no\n" > /boot/loader/loader.conf

printf "title Arch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\n" > /boot/loader/entries/arch.conf
printf "title Arch (LTS)\nlinux /vmlinuz-linux-lts\ninitrd /initramfs-linux-lts.img\n" > /boot/loader/entries/arch-lts.conf
printf "title Arch (Xanmod RT)\nlinux /vmlinuz-linux-xanmod-rt\ninitrd /initramfs-linux-xanmod-rt.img\n" > /boot/loader/entries/arch-xanmod-rt.conf
sleep 1s

if grep 'vendor' /proc/cpuinfo | uniq | grep -i -o amd; then
    pacman -S amd-ucode --noconfirm
    printf "initrd /amd-ucode.img\n" >> /boot/loader/entries/arch.conf
    printf "initrd /amd-ucode.img\n" >> /boot/loader/entries/arch-lts.conf
    printf "initrd /amd-ucode.img\n" >> /boot/loader/entries/arch-xanmod-rt.conf
    sleep 1s
elif grep 'vendor' /proc/cpuinfo | uniq | grep -i -o intel; then
    pacman -S intel-ucode --noconfirm
    printf "initrd /intel-ucode.img\n" >> /boot/loader/entries/arch.conf
    printf "initrd /intel-ucode.img\n" >> /boot/loader/entries/arch-lts.conf
    printf "initrd /intel-ucode.img\n" >> /boot/loader/entries/arch-xanmod-rt.conf
    sleep 1s
fi

if [[ -f /should.encrypt ]]; then
  MAPPERROOT=$(blkid -s UUID -o value /dev/mapper/root)
  printf "options cryptdevice=UUID=%s:root root=UUID=%s rootflags=subvol=@ rw splash\n" "$UUIDROOTPART" "$MAPPERROOT" >> /boot/loader/entries/arch.conf
  printf "options cryptdevice=UUID=%s:root root=UUID=%s rootflags=subvol=@ rw splash\n" "$UUIDROOTPART" "$MAPPERROOT" >> /boot/loader/entries/arch-lts.conf
  printf "options cryptdevice=UUID=%s:root root=UUID=%s rootflags=subvol=@ rw splash\n" "$UUIDROOTPART" "$MAPPERROOT" >> /boot/loader/entries/arch-xanmod-rt.conf
else
  UUIDROOTPART=$(blkid -s UUID -o value /dev/"$ROOTPART")

  printf "options root=UUID=%s rootflags=subvol=@ rw splash\n" "$UUIDROOTPART" >> /boot/loader/entries/arch.conf
  printf "options root=UUID=%s rootflags=subvol=@ rw splash\n" "$UUIDROOTPART" >> /boot/loader/entries/arch-lts.conf
  printf "options root=UUID=%s rootflags=subvol=@ rw splash\n" "$UUIDROOTPART" >> /boot/loader/entries/arch-xanmod-rt.conf
fi


# NVIDIA ONLY
if [[ -f /hasnvidia.gpu ]]; then
    pacman -S nvidia-dkms libglvnd nvidia-utils opencl-nvidia lib32-libglvnd lib32-nvidia-utils lib32-opencl-nvidia nvidia-settings --noconfirm --needed
    sleep 1s

    # Enable NVdia modules, must be in that order
    sed -i 's/MODULES=(btrfs vfio vfio_pci vfio_iommu_type1 virtio-gpu virtio virtio_scsi virtio_blk virtio_pci virtio_net virtio_ring vmd qxl usbhid xhci_hcd btusb)/MODULES=(btrfs vfio vfio_pci vfio_iommu_type1 virtio-gpu virtio virtio_scsi virtio_blk virtio_pci virtio_net virtio_ring vmd qxl usbhid xhci_hcd btusb nvidia nvidia_modeset nvidia_uvm nvidia_drm)/g' /etc/mkinitcpio.conf
    sleep 1s

    # Add nvidia-drm.modeset=1 at the end of options root=PARTUUID....
if [[ -f /should.encrypt ]]; then
    sed -i "s/options cryptdevice=UUID=.*/options cryptdevice=UUID=%s:root root=UUID=%s rootflags=subvol=@ rw splash nouveau.modeset=0 nvidia-drm.modeset=1/g" "$UUIDROOTPART" "$MAPPERROOT" /boot/loader/entries/arch.conf
    sed -i "s/options cryptdevice=UUID=.*/options cryptdevice=UUID=%s:root root=UUID=%s rootflags=subvol=@ rw splash nouveau.modeset=0 nvidia-drm.modeset=1/g" "$UUIDROOTPART" "$MAPPERROOT" /boot/loader/entries/arch-lts.conf
    sed -i "s/options cryptdevice=UUID=.*/options cryptdevice=UUID=%s:root root=UUID=%s rootflags=subvol=@ rw splash nouveau.modeset=0 nvidia-drm.modeset=1/g" "$UUIDROOTPART" "$MAPPERROOT" /boot/loader/entries/arch-xanmod-rt.conf
  else
    sed -i "s/options root=UUID=.*/options root=UUID=%s rootflags=subvol=@ rw splash nouveau.modeset=0 nvidia-drm.modeset=1/g" "$UUIDROOTPART" /boot/loader/entries/arch.conf
    sed -i "s/options root=UUID=.*/options root=UUID=%s rootflags=subvol=@ rw splash nouveau.modeset=0 nvidia-drm.modeset=1/g" "$UUIDROOTPART" /boot/loader/entries/arch-lts.conf
    sed -i "s/options root=UUID=.*/options root=UUID=%s rootflags=subvol=@ rw splash nouveau.modeset=0 nvidia-drm.modeset=1/g" "$UUIDROOTPART" /boot/loader/entries/arch-xanmod-rt.conf
fi

    # Make a hook for pacman so we can update and build the new drivers or we'll get blank screen on load
    # Create hooks folder
    mkdir -p /etc/pacman.d/hooks
    sleep 1s

    # Add nvidia hook
    printf "[Trigger]\nOperation=Install\nOperation=Upgrade\nOperation=Remove\nType=Package\nTarget=nvidia\n\n[Action]\nDepends=mkinitcpio\nWhen=PostTransaction\nExec=/usr/bin/mkinitcpio -P\n" > /etc/pacman.d/hooks/nvidia.hook
    sleep 1s
fi

# Update mkinitcpio
mkinitcpio -P
sleep 1s

# Update bootctl and enable auto-update service
bootctl --path=/boot update
systemctl enable systemd-boot-update.service

# Visudo
echo
echo "Uncomment %wheel and add Defaults"
echo '%wheel ALL=(ALL:ALL) ALL'
echo 'Defaults insults'
echo 'Defaults rootpw'
echo 'Defaults timestamp_type=global'
echo 'Defaults passwd_timeout=0'
read -rp "Open sudoers now?"
EDITOR=nvim sudo -E visudo
sleep 1s

# Appending group "Wheel" to $USERNAME
usermod -aG wheel "$USERNAME"
sleep 1s

if ! [[ -d "$HOME"/Documents ]]; then
    mkdir -p "$HOME"/Documents
    sleep 1s
    chown -R "$USERNAME:$GROUPNAME" "$HOME"/Documents
fi

echo
printf "Copying /dotfiles to %s/Documents/" "$HOME"
echo
cp -r /ArchS "$HOME"/Documents/
sleep 1s

echo
printf "Giving ownership of \"%s/Documents/dotfiles\" to User: %s Group: %s" "$HOME" "$USERNAME" "$GROUPNAME"
echo
chown -R "$USERNAME:$GROUPNAME" "$HOME"/Documents/dotfiles
sleep 1s

echo
echo "Enabling autodefrag"
echo
sed -i 's/subvolid=/autodefrag,subvolid=/g' /etc/fstab

echo
echo "CLONING: paru"
echo
git clone https://aur.archlinux.org/paru.git && cd paru

echo
echo "INSTALLING: paru"
echo
makepkg -si --noconfirm
cd ..
rm -rf paru

echo
echo "Setting vifm as paru's File Manager"
echo
sed -i "s|\#\[bin]|[bin]|g" /etc/paru.conf
sed -i "s|#FileManager|FileManager|g" /etc/paru.conf
sync

# Remove hasnvidia.gpu from /mnt
if [[ -f /hasnvidia.gpu ]]; then
  rm -f /hasnvidia.gpu
fi

# Remove should.encrypt from /mnt
if [[ -f /should.encrypt ]]; then
  rm -f /should.encrypt
fi
sleep 2s

exit 0
