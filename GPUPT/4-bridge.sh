#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
  echo
  echo "Don't run this script as root."
  echo
  sleep 1s
  exit 1
fi

HOMEPATH="$HOME"
netdevice="null"

if ! pacman -Q | grep 'netctl'; then
  echo
  echo "Installing netctl"
  echo
  sudo pacman -S netctl --noconfirm --needed && sync
  echo
fi

if ! grep -i "net.bridge.bridge-nf-call-ip6tables=0" /etc/sysctl.d/*; then
  if grep -i "net.bridge.bridge-nf-call-ip6tables=1" /etc/sysctl.d/*; then
    sudo sed -i 's/net.bridge.bridge-nf-call-ip6tables=0/"net.bridge.bridge-nf-call-ip6tables=1/g' /etc/sysctl.d/*
  else
    printf "net.bridge.bridge-nf-call-ip6tables=0\n" | sudo tee -a /etc/sysctl.d/99-bridge.conf
  fi
  sync
fi
if ! grep -i "net.bridge.bridge-nf-call-iptables=0" /etc/sysctl.d/*; then
  if grep -i "net.bridge.bridge-nf-call-iptables=1" /etc/sysctl.d/*; then
    sudo sed -i 's/net.bridge.bridge-nf-call-iptables=0/"net.bridge.bridge-nf-call-iptables=1/g' /etc/sysctl.d/*
  else
    printf "net.bridge.bridge-nf-call-iptables=0\n" | sudo tee -a /etc/sysctl.d/99-bridge.conf
  fi
  sync
fi
if ! grep -i "net.bridge.bridge-nf-call-arptables=0" /etc/sysctl.d/*; then
  if grep -i "net.bridge.bridge-nf-call-arptables=0" /etc/sysctl.d/*; then
    sudo sed -i 's/net.bridge.bridge-nf-call-arptables=0/"net.bridge.bridge-nf-call-arptables=1/g' /etc/sysctl.d/*
  else
    printf "net.bridge.bridge-nf-call-arptables=0\n" | sudo tee -a /etc/sysctl.d/99-bridge.conf
  fi
  sync
fi

sudo sysctl --system
sleep 1s

if ! grep -i "br_netfilter" /etc/modules-load.d/*; then
  printf "br_netfilter\n" | sudo tee /etc/modules-load.d/br_netfilter.conf && sync
fi

if ! [ -f "/etc/udev/rules.d/99-bridge.rules" ]; then
  printf "ACTION==\"add\", SUBSYSTEM==\"module\", KERNEL==\"br_netfilter\", RUN+=\"/sbin/sysctl -p /etc/sysctl.d/99-bridge.conf\"" | sudo tee /etc/udev/rules.d/99-bridge.rules
  sync
  sudo systemctl restart systemd-udevd.service
fi

if ! [ -d "/etc/netctl" ]; then
  sudo mkdir "/etc/netctl" && sync
fi

if [ -f "/etc/netctl/kvm-bridge" ]; then
  sudo mv "/etc/netctl/kvm-bridge" "/etc/netctl/kvm-bridge.old" && sync
fi

if ! [ -f "/etc/netctl/kvm-bridge" ]; then
  sudo touch /etc/netctl/kvm-bridge && sync
  ip addr
  answereth=n
  while [ "${answereth,,}" = n ]; do
    echo
    echo
    echo "What's your main network device? Should start with \"enp\""
    echo
    read -r ETH
    if ip addr | grep -iq "$ETH"; then
      netdevice=$ETH
      answereth=y
      sync
    else
      echo
      echo "\"$ETH\" doesn't exist. Try again"
      echo
      echo
      sleep 1s
    fi
  done
  printf "Description=\"Bridge Interface br10 : %s, virbr0\"\n" "$netdevice" | sudo tee /etc/netctl/kvm-bridge && sync
  printf "Interface=br10\n" | sudo tee -a /etc/netctl/kvm-bridge && sync
  printf "Connection=bridge\n" | sudo tee -a /etc/netctl/kvm-bridge && sync
  printf "BindsToInterfaces=(%s virbr0)\n" "$netdevice" | sudo tee -a /etc/netctl/kvm-bridge && sync
  printf "IP=dhcp\n" | sudo tee -a /etc/netctl/kvm-bridge && sync
fi

if ! [ -f "$HOMEPATH/bridged-network.xml" ]; then
  printf "<network>\n" | tee "$HOMEPATH/bridged-network.xml" && sync
  printf "  <name>br10</name>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "  <forward mode=\"nat\">\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "    <nat>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "      <port start=\"1024\" end=\"65535\"/>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "    </nat>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "  </forward>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "  <bridge name=\"virbr1\" stp=\"off\" delay=\"0\"/>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "  <domain name=\"br10\"/>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "  <ip address=\"192.168.100.1\" netmask=\"255.255.255.0\">\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "    <dhcp>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "      <range start=\"192.168.100.2\" end=\"192.168.100.254\"/>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "    </dhcp>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "  </ip>\n" | tee -a "$HOMEPATH/bridged-network.xml" && sync
  printf "</network>" | tee -a "$HOMEPATH/bridged-network.xml" && sync
fi

if ! grep -iq 'allow virbr0' /etc/qemu/bridge.conf; then
  printf "\nallow virbr0\n" | sudo tee -a /etc/qemu/bridge.conf && sync
fi
if ! grep -iq 'allow virbr1' /etc/qemu/bridge.conf; then
  printf "\nallow virbr1\n" | sudo tee -a /etc/qemu/bridge.conf && sync
fi
if ! grep -iq 'allow br10' /etc/qemu/bridge.conf; then
  printf "allow br10\n" | sudo tee -a /etc/qemu/bridge.conf && sync
fi

sudo systemctl daemon-reload

sudo virsh net-define "$HOMEPATH/bridged-network.xml"
sudo virsh net-start br10
sudo virsh net-autostart br10
sleep 5s

sudo netctl enable kvm-bridge
sudo netctl start kvm-bridge
sleep 1s

sudo systemctl disable NetworkManager-wait-online.service
sudo systemctl mask NetworkManager-wait-online.service
sleep 1s

sudo systemctl enable setkvm-bridge
sudo systemctl start setkvm-bridge
sleep 1s

sudo nmcli con reload
sudo nmcli con add type bridge-slave ifname "$netdevice" master br10
sudo nmcli con reload

BRLKNAME="bridge-slave-$netdevice"

GETNETDEVUUID=$(nmcli -t -f NAME,UUID,DEVICE con | grep -i ".*:$netdevice")
GETBRIDGEUUID=$(nmcli -t -f NAME,UUID,DEVICE con | grep -i ".*:br10")
GETLKUUID=$(nmcli -t -f NAME,UUID,DEVICE con | grep -i ".*:$BRLKNAME")
GETLEFTNETUUID=${GETNETDEVUUID%:*}
GETLEFTBRUUID=${GETBRIDGEUUID%:*}
GETLEFTLKUUID=${GETLKUUID%:*}
GETRIGHTNETUUID=${GETLEFTNETUUID#*:}
GETRIGHTBRUUID=${GETLEFTBRUUID#*:}
GETRIGHTLKUUID=${GETLEFTLKUUID#*:}

NETDEVUUID=$GETRIGHTNETUUID
BRIDGEUUID=$GETRIGHTBRUUID
LINKUUID=$GETRIGHTLKUUID

sudo nmcli con mod "$BRIDGEUUID" connection.autoconnect no && sync
nmcli con mod "$LINKUUID" connection.autoconnect yes
sudo nmcli con reload

sudo nmcli con down "$NETDEVUUID"
sudo nmcli con up "$BRIDGEUUID"
sudo nmcli con up "$LINKUUID"
sudo nmcli con reload

if ! [ -d "$HOMEPATH/.config/autostart" ]; then
  mkdir -p "$HOMEPATH/.config/autostart" && sync
fi

if ! [ -d "$HOMEPATH/.apps" ]; then
  mkdir -p "$HOMEPATH/.apps" && sync
fi

# printf "/#!/usr/bin/env bash\n\n" | tee "$HOMEPATH/.apps/setbridge.sh"
# printf "netctl start kvm-bridge\n" | tee "$HOMEPATH/.apps/setbridge"
printf "nmcli con down %s\n" "$netdevice" | tee "$HOMEPATH/.apps/setbridge" && sync
printf "nmcli con up %s\n" "$BRIDGEUUID" | tee -a "$HOMEPATH/.apps/setbridge" && sync
printf "nmcli con up %s\n" "$LINKUUID" | tee -a "$HOMEPATH/.apps/setbridge" && sync

chmod +x "$HOMEPATH/.apps/setbridge"

printf "[Unit]\n" | sudo tee "/etc/systemd/system/setkvm-bridge.service" && sync
printf "Description=Set Bridge\n\n" | sudo tee -a "/etc/systemd/system/setkvm-bridge.service" && sync
printf "[Service]\n" | sudo tee -a "/etc/systemd/system/setkvm-bridge.service" && sync
printf "ExecStart=sudo %s/.apps/setbridge\n" "$HOMEPATH" | sudo tee -a "/etc/systemd/system/setkvm-bridge.service" && sync
printf "Type=idle\n\n" | sudo tee -a "/etc/systemd/system/setkvm-bridge.service" && sync
printf "[Install]\n" | sudo tee -a "/etc/systemd/system/setkvm-bridge.service" && sync
printf "WantedBy=multi-user.target\n" | sudo tee -a "/etc/systemd/system/setkvm-bridge.service" && sync

# echo
# echo
# echo "To use the bridged network in your VM create a new NIC or Edit existing"
# echo
# echo
# echo "\"Network source:\" select \"Bridge device...\""
# echo "\"Device Name:\" must be \"br10\""
# echo "\"Device model:\" choose \"virtio\""
# echo
# echo
# echo "If the NIC MAC address doesn't match the MAC address of the network copy-paste it"
# echo "Open Virtual Machine Manager click on Edit->Connection Details, click on \"br10\" and click on \"XML\" tab"
# echo "Copy the \"mac address\" to your VM NIC's mac address"
# echo
# echo
# echo "Press any key when you're done"
# echo
# sleep 1s
# echo
# echo "Done."
# echo
# echo "Note, after these changes, the loading screen before the login screen will take much longer, around 3 minutes"
# echo "This is permanent, it'll happen everytime you boot/reboot"
# echo "Probably be cause it's trying to connect to the internet and waits 3 mins to give up trying"
# echo
# sleep 1s
# echo
# echo "Press Y to reboot now or any key if you plan to manually reboot later."
# echo
# read -r REBOOT
# if [ "${REBOOT,,}" = y ]; then
#   systemctl reboot
# fi
exit 0
