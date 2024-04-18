#!/bin/bash

ISKVM=n
CHECKKVM=$(sudo dmesg | grep "Hypervisor detected")

if [[ "$CHECKKVM" =~ "KVM" ]] ;then
  ISKVM=y
  echo
  echo "Virtual Machine Detected"
  echo
  sleep 1s
fi

MOUNTOPTIONS=""

if [[ ${ISKVM,,} == "y" ]]; then
  MOUNTOPTIONS="compress=zstd:3,noatime,ssd,defaults,x-mount.mkdir,subvol="
else
  MOUNTOPTIONS="compress=zstd:3,space_cache=v2,noatime,ssd,defaults,x-mount.mkdir,subvol="
fi

VALIDPARTONE=n
VALIDPARTTWO=n
VALIDPARTTHREE=n
VALIDSHOULDENCRYPT=n
EFIPART=null
ROOTPART=null
HOMEPART=null
ENCRYPTPARTITIONS=n


while [[ ${VALIDSHOULDENCRYPT,,} = n ]]; do
    read -rp "Do you want to encrypt the system? Y - yes | N - No: " SHOULDENCRYPT
    ENCRYPTPARTITIONS=$SHOULDENCRYPT
    if [[ ${ENCRYPTPARTITIONS,,} = "y" ]]; then
      VALIDSHOULDENCRYPT=y
      touch /mnt/should.encrypt
      echo 'y' > /mnt/should.encrypt
      sleep 1s
    elif [[ ${ENCRYPTPARTITIONS,,} = "n" ]]; then
        VALIDSHOULDENCRYPT=y
    else
        echo
        printf "Please type either \"Y\" or \"N\""
        echo
    fi
done

lsblk
while [[ ${VALIDPARTONE,,} = n ]]; do
    read -rp "Enter the name of the EFI partition (eg. sda1, nvme0n1p1): " PARTONE
    EFIPART=$PARTONE
    if lsblk | grep -w "$EFIPART"; then
        VALIDPARTONE=y
    else
        echo
        printf "Could not find /dev/%s, try again" "$EFIPART"
        echo
    fi
done
sleep 1s
echo
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
sleep 1s
echo
while [[ ${VALIDPARTTHREE,,} = n ]]; do
    read -rp "Enter the name of the HOME partition (eg. sda3, nvme0n1p3): " PARTTHREE
    HOMEPART=$PARTTHREE
    if lsblk | grep -w "$HOMEPART"; then
        VALIDPARTTHREE=y
    else
        echo
        printf "Could not find /dev/%s, try again" "$HOMEPART"
        echo
    fi
done
sleep 1s
echo

# Sync time
timedatectl set-ntp true
sleep 1s

if [[ ${ENCRYPTPARTITIONS,,} == "y" ]]; then
  echo
  echo 'Modprobing dm-crypt and dm-mod'
  echo
  modprobe dm-crypt
  sleep 1s
  modprobe dm-mod
  sleep 1s

  echo
  echo "Encrypting \"/dev/$ROOTPART\", type \"YES\" must be uppercase!"
  echo
  sleep 1s
  cryptsetup luksFormat -v -s 512 -h sha512 /dev/"$ROOTPART"
  sleep 1s

  echo
  echo "Encrypting \"/dev/$HOMEPART\", type \"YES\" must be uppercase!"
  echo
  sleep 1s
  cryptsetup luksFormat -v -s 512 -h sha512 /dev/"$HOMEPART"
  sleep 1s

  echo
  echo "Opening \"/dev/$ROOTPART\" use your encryption password you setup earlier"
  echo
  sleep 1s
  cryptsetup open /dev/"$ROOTPART" root
  sleep 1s

  echo
  echo "Opening \"/dev/$HOMEPART\" use your encryption password you setup earlier"
  echo
  sleep 1s
  cryptsetup open /dev/"$HOMEPART" home
  sleep 1s
fi

# Format partitions
mkfs.fat -F 32 /dev/"$EFIPART"
mkfs.btrfs -f /dev/"$ROOTPART"
mkfs.btrfs -f /dev/"$HOMEPART"
if [[ ${ENCRYPTPARTITIONS,,} == "y" ]]; then
  mkfs.btrfs -f /dev/mapper/root
  mkfs.btrfs -f /dev/mapper/home
fi
sleep 1s

# Mount the partitions
if [[ ${ENCRYPTPARTITIONS,,} == "y" ]]; then
  mount /dev/mapper/root /mnt
else
  mount /dev/"$ROOTPART" /mnt
fi
btrfs su cr /mnt/@
btrfs su cr /mnt/@opt
btrfs su cr /mnt/@swap
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@log
sleep 1s
umount /mnt

if [[ ${ENCRYPTPARTITIONS,,} == "y" ]]; then
  mount /dev/mapper/home /mnt
  mount -o "$MOUNTOPTIONS"@ /dev/mapper/root /mnt
  mkdir -p /mnt/{boot,swap,home,.snapshots,opt,var/{cache,log}}
  mount -o "$MOUNTOPTIONS"@opt /dev/mapper/root /mnt/opt
  mount -o "$MOUNTOPTIONS"@swap /dev/mapper/root /mnt/swap
  mount -o "$MOUNTOPTIONS"@snapshots /dev/mapper/root /mnt/.snapshots
  mount -o "$MOUNTOPTIONS"@cache /dev/mapper/root /mnt/var/cache
  mount -o "$MOUNTOPTIONS"@log /dev/mapper/root /mnt/var/log
  mount -o "$MOUNTOPTIONS"@home /dev/mapper/home /mnt/home
  mount /dev/"$EFIPART" /mnt/boot
else
  mount /dev/"$HOMEPART" /mnt
  mount -o "$MOUNTOPTIONS"@ /dev/"$ROOTPART" /mnt
  mkdir -p /mnt/{boot,swap,home,.snapshots,opt,var/{cache,log}}
  mount -o "$MOUNTOPTIONS"@opt /dev/"$ROOTPART" /mnt/opt
  mount -o "$MOUNTOPTIONS"@swap /dev/"$ROOTPART" /mnt/swap
  mount -o "$MOUNTOPTIONS"@snapshots /dev/"$ROOTPART" /mnt/.snapshots
  mount -o "$MOUNTOPTIONS"@cache /dev/"$ROOTPART" /mnt/var/cache
  mount -o "$MOUNTOPTIONS"@log /dev/"$ROOTPART" /mnt/var/log
  mount -o "$MOUNTOPTIONS"@home /dev/"$HOMEPART" /mnt/home
  mount /dev/"$EFIPART" /mnt/boot
fi
btrfs su cr /mnt/@home
sleep 1s
umount /mnt

# Prep
pacstrap -K /mnt


PKGS=(
  'base'                #
  'base-devel'          #
  'btrfs-progs'         #
  'efibootmgr'          #
  'linux'               #
  'linux-firmware'      #
  'linux-headers'       #
  'linux-lts'           #
  'linux-lts-headers'   #
  'dkms'                #
  'neovim'              # Text Editor
  'vim'                 # Text Editor
  'git'                 #
  'pipewire'            #
  'pipewire-audio'      #
  'pipewire-alsa'       #
  'pipewire-pulse'      #
  'pipewire-jack'       #
  'pipewire-zeroconf'   #
  'gst-plugin-pipewire' #
  'wireplumber'         #
  'qpwgraph'            #
  'pulsemixer'          #
  'pciutils'            #
  'usbutils'            #
)

for PKG in "${PKGS[@]}"; do
    echo
    echo "INSTALLING: ${PKG}"
    echo
    pacstrap -K /mnt "$PKG"
    echo
    sleep 1s
done

sleep 1s

# Populate fstab
genfstab -Up /mnt >> /mnt/etc/fstab
sleep 1s

# Copy current folder to /mnt
cp -r dotfiles /mnt/
sleep 1s

if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
    touch /mnt/hasnvidia.gpu
    echo 'y' > /mnt/hasnvidia.gpu
    sleep 1s
fi

# chroot into mnt
arch-chroot /mnt ./dotfiles/.install/0.1_archinstall.sh
sleep 2s

# Remove ArchS from /mnt
echo
echo 'Removing /mnt/dotfiles'
echo
rm -rf /mnt/dotfiles
sleep 2s

# Unmount all drives (-R will remove everything mounted to that path)
echo
echo 'Unmounting all drives'
echo
umount -R /mnt/sys
sleep 2s

umount -R /mnt
sleep 2s

echo
echo "Done..."
echo
echo "Press Y to reboot now or N if you plan to manually reboot later."
echo
read -r REBOOT
if [ "${REBOOT,,}" = y ]; then
    shutdown -r now
fi
exit 0
