#!/usr/bin/env sh

#####################################################################################################################
# SERVER - LINUX
#####################################################################################################################

POOLNAME="games"
DEVNAME="/dev/sdb"
DSNAME="main"
IPADD=192.168.1.60
NETMASK=255.255.255.0

# Creates a new, single ZFS pool. No advanced configs such as mirror, RAIDZ, etc
#
# Needs zfs-dkms, zfs-utils and gdisk
sudo pacman -S zfs-dkms, zfs-utils nfs-utils gdisk --noconfirm --needed
#
# Identify disk you want to use
lsblk
#
# Clear Disk
sudo sgdisk --zap-all "$DEVNAME"
#
# Create a ZFS partition
sudo sgdisk --new=1:0:0 --typecode=1:BF00 "$DEVNAME"
#
# Create zpool
#
# CHOOSE ONLY ONE
#
#####################################################################################################################
# LINUX ONLY Pool (Never mount/access from non-linux OS)
sudo zpool create -f -d -m none -o ashift=12 -O atime=off -o feature@lz4_compress=enabled "$POOLNAME" "$DEVNAME"1
#####################################################################################################################
#
#####################################################################################################################
# Cross-Platform Pool ("All" OS-friendly but loses some features)
# Change POOLNAME at the top of this script to the name you want to give this ZFS pool.
# Change DEVNAME at the top of this script to the device you want.
sudo zpool create -f -d -m none -o ashift=12 -o feature@lz4_compress=enabled -o feature@multi_vdev_crash_dump=disabled -o feature@large_dnode=disabled -o feature@sha512=disabled -o feature@skein=disabled -o feature@edonr=disabled -o feature@userobj_accounting=disabled "$POOLNAME" "$DEVNAME"1
#####################################################################################################################
#
# Create a dataset
# Change DSNAME at the top of this script to the name you want to give this Dataset.
# You can add as many datasets as you want now or later
sudo zfs create "$POOLNAME"/"$DSNAME"
sudo zfs set compression=lz4 "$POOLNAME"/"$DSNAME"
sudo zfs set atime=off "$POOLNAME"/"$DSNAME"
sudo zfs set mountpoint=/mnt/"$POOLNAME" "$POOLNAME"
#
# Change it's quota according to it's size
sudo zfs set quota=1T "$POOLNAME"/"$DSNAME"
#
# Set it to be shareable
sudo zfs set sharenfs=on "$POOLNAME"/"$DSNAME"
# sudo zfs set share=name="$DSNAME",path=/mnt/games/main,prot=nfs "$POOLNAME"/"$DSNAME"
# Share it
sudo zfs share "$POOLNAME"/"$DSNAME"
#
# Check you datasets if you want
zfs get all "$POOLNAME"/"$DSNAME"
#
# You can change the owner
sudo chown root:root /mnt/"$POOLNAME"
sudo chmod -R 0755 /mnt/"$POOLNAME"
sudo chown "$(logname):$(logname)" -R /mnt/"$POOLNAME"/"$DSNAME"
sudo chmod 0777 -R /mnt/"$POOLNAME"/"$DSNAME"
#
# When you're done you can finalise the changes by exporting the pool (Same as unmount)
sudo zpool export "$POOLNAME"
#
# To mount it run the following command, avoid using /dev/sdX since it'll cause problems when/if you
# add, remove or rearrange your drives
sudo zpool import -d /dev/disk/by-id "$POOLNAME"
#
# To automount, you must explicitly enable these services and targets
sudo systemctl enable zfs-import-cache.service
sudo systemctl enable zfs.target
sudo systemctl enable zfs-import.target
sudo systemctl enable zfs-mount.service
sudo systemctl enable zfs-share.service
sudo systemctl enable nfs-server.service
#
# And set which pool you want to automount, change "$POOLNAME" to the one of you choosing
sudo zpool set cachefile=/etc/zfs/zpool.cache "$POOLNAME"
#
# Create a copy of exports to modify it safely
sudo mv /etc/exports /etc/exports.old

EXVAR="/mnt/$POOLNAME/$DSNAME $IPADD/$NETMASK\(rw,insecure,sync,no_subtree_check,no_root_squash\)"

sudo bash -c "echo $EXVAR >> /home/archuser/testdir/exports"

#
# Done
#
#####################################################################################################################
# CLIENT - LINUX
#####################################################################################################################
#
# Install nfs-utils
sudo pacman -S nfs-utils autofs --noconfirm --needed
#
# Check if server exists, it should show all folders you made available in "/etc/exports"
showmount -e 192.168.1.60
#
# Create the nfs folder plus a folder for each folder in exports
sudo mkdir -p /mnt/nfs
sudo mkdir /mnt/nfs/main
#
# Now mount them
sudo mount 192.168.1.60:/mnt/games/main /mnt/nfs/main
#
# If everything went right you can unmount and delete the main folder
sudo umount -R /mnt/nfs/main
sudo rm -r /mnt/nfs/main
#
# Enable autofs service if it's not
sudo systemctl enable --now autofs.service
#
# Now let's edit autofs config files
printf "\n\n/mnt/nfs /etc/autofs/auto.nfs --ghost --timeout=60\n" | sudo tee -a /etc/autofs/auto.master
#
AUTOFSVAR="$DSNAME -fstype=nfs4,rw $IPADD:/mnt/$POOLNAME/$DSNAME"
sudo bash -c "echo $AUTOFSVAR >> /etc/autofs/auto.nfs"
#####################################################################################################################
# CLIENT - WINDOWS
#####################################################################################################################
# Use Winutil
# Open powershell as admin and run the command below
irm https://christitus.tech/win | iex
#
# Click on "Config" tab and select "NFS - Network File System" and then click "Install Features"
# Reboot windows
#
# Open CMD and type
mount -o nolock -o mtype=hard -o timeout=60 \\"$IPADD"\mnt\$POOLNAME\$DSNAME Z:
#
# Now open "This PC" on the left you'll see "Network", click on it, if it's disabled enable it
# Choose whether you want to make it available publicly or only in your home network
#
# After it's done right-click the "Network" icon again and select "Map Network Drive"
# Fill in the following
\\"$IPADD"\mnt\$POOLNAME\$DSNAME
#
# Select the drive letter you want
# Enable "Reconnect at sign-in"
#  Click "Finish" and wait for it. It'll be available in your "This PC"
