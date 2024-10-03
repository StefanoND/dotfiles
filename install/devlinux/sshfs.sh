#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

# This is for SSHFS, if it's not configured, sshfs config will be ignored
LNAME=HOSTUSERNAME
IPADD=HOSTIPADDRESS
PATH=/HOST/PATH/TO/SHARED/FOLDER

cd "$HOME"/dotfiles

sudo groupadd fuse
sudo usermod -a -G fuse "$(logname)"

mkdir "$HOME"/SHARED

sshfs "$LNAME@$IPADD:$PATH" "$HOME"/SHARED

"$LNAME@$IPADD:$PATH" "$HOME"/SHARED fuse.sshfs

FSTABOPTS="defaults,x-systemd.automount,_netdev,user,idmap=user,reconnect,follow_symlinks,identityfile=$HOME/.ssh/id_rsa,allow_other,default_permissions,uid=1000,gid=1000"
printf "\n%s@%s:%s  /home/archuser/SHARED fuse.sshfs %s 0 0\n" "$LNAME" "$IPADD" "$PATH" "$FSTABOPTS" | sudo tee -a /etc/fstab
sudo systemctl daemon-reload

ssh-keygen -t rsa -f "$HOME"/.ssh/sshfs_rsa

echo
echo "Copy $HOME/.ssh/sshfs_rsa.pub to the Host's authorized keys, like so"
echo
echo "ssh-copy-id -i $HOME/.ssh/sshfs_rsa.pub $LNAME@$IPADD"
echo
echo
echo
echo "Then, in the Host, you'll copy it to the authorized_keys file, like so"
echo
echo "cat $HOME/sshfs_rsa.pub >> $HOME/.ssh/authorized_keys"
echo
