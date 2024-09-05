#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

echo
echo "Create and setup a VM first"
echo
echo "Press Y if you've already done it"
echo
read CREATEDVM
if [[ ${CREATEDVM,,} = y ]]; then
    echo
else
    exit 0
fi

clear
echo
echo
echo "      _        _                                     ___                               "
echo "     / \   ___| |_ ___ _ __ _ __  _   _ _ __ ___    / _ \ _ __ ___   ___  __ _  __ _   "
echo "    / _ \ / _ \ __/ _ \ '__| '_ \| | | | '_ ' _ \  | | | | '_ ' _ \ / _ \/ _' |/ _' |  "
echo "   / ___ \  __/ ||  __/ |  | | | | |_| | | | | | | | |_| | | | | | |  __/ (_| | (_| |  "
echo "  /_/   \_\___|\__\___|_|  |_| |_|\__,_|_| |_| |_|  \___/|_| |_| |_|\___|\__, |\__,_|  "
echo "                                                                         |___/         "
echo "                                  Post-Install Script"
echo
echo
sleep 2s
clear

vmname=null

while [[ ${vmname,,} == null ]] || [[ ${vmname,,} == "" ]]; do
   echo
   echo "What's the VM's name?"
   echo
   read OSNAME

    if [[ ${OSNAME,,} == null ]] || [[ ${OSNAME,,} == "" ]]; then
        echo
        echo "You must give a name!"
        echo
        sleep 1s
    else
        vmname=$OSNAME
    fi
done

sleep 1s

hookspath=/etc/libvirt/hooks/qemu.d/

cpath="$PWD"
hpath="$cpath"/hooks

sleep 1s

if ! [[ -d /etc/libvirt/hooks ]]; then
    sudo mkdir -p /etc/libvirt/hooks
    sync
fi
if ! [[ -d /usr/share/vgabios ]]; then
    sudo mkdir -p /usr/share/vgabios
    sync
fi
if ! [[ -d "$hookspath" ]]; then
    sudo mkdir -p "$hookspath"
    sync
fi
if [[ -f /etc/libvirt/hooks/qemu ]]; then
    sudo mv /etc/libvirt/hooks/qemu /etc/libvirt/hooks/qemu.old
    sync
fi
if [[ -f /etc/systemd/system/libvirt-nosleep@.service ]]; then
    sudo rm /etc/systemd/system/libvirt-nosleep@.service
    sync
fi

chmod +x "$hpath"/*.sh
chmod +x "$hpath"/osname/prepare/begin/*.sh
chmod +x "$hpath"/osname/release/end/*.sh
chmod +x "$hpath"/qemu
chmod +x "$hpath"/libvirt-nosleep@.service
sleep 1s

sudo cp "$hpath"/osname /etc/libvirt/hooks/qemu.d/"$vmname"
sudo cp "$hpath"/libvirt-nosleep@.service /etc/systemd/system/
sudo cp "$hpath"/qemu /etc/libvirt/hooks/
sleep 1s


sudo cp "$hpath"/dev-hugepages.mount /etc/systemd/system/
sync
sleep 1s

sudo systemctl restart libvirtd
sleep 1s

echo
echo "Done"
echo

exit 0
