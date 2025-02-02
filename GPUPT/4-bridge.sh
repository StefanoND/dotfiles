#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
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

if ! pacman -Q | grep 'netctl'; then
    echo
    echo "Installing netctl"
    echo
    sudo pacman -S netctl --noconfirm --needed
    sync
    echo
fi

if ! test -e /etc/sysctl.d/bridge.conf; then
    echo
    echo "Disabling netfilter for bridges."
    echo
    printf "net.bridge.bridge-nf-call-ip6tables=0\nnet.bridge.bridge-nf-call-iptables=0\nnet.bridge.bridge-nf-call-arptables=0" | sudo tee /etc/sysctl.d/99-netfilter-bridge.conf
    sync
    echo
fi

if ! test -e /etc/modules-load.d/br_netfilter.conf; then
    echo
    echo "Making netfilter module to load at boot."
    echo
    printf "br_netfilter" | sudo tee /etc/modules-load.d/br_netfilter.conf
    sync
    echo
fi

if ! test -e /etc/udev/rules.d/99-bridge.rules; then
    echo
    echo "Creating rule to run the previous settings when the bridge module is loaded."
    echo
    printf "ACTION==\"add\", SUBSYSTEM==\"module\", KERNEL==\"br_netfilter\", RUN+=\"/sbin/sysctl -p /etc/sysctl.d/bridge.conf\"" | sudo tee /etc/udev/rules.d/99-bridge.rules
    sync
    echo
fi

if ! test -e /etc/netctl/kvm-bridge; then
      sudo touch /etc/netctl/kvm-bridge
      echo
      echo "Creating the KVM Bridge."
      echo
      ip addr
      answereth=n
      netdevice=null
      while [ "${answereth,,}" = n ]; do
          echo
          echo "What's your main network device? Should start with \"enp\""
          echo
          read ETH
          if [[ `ip addr | grep "$ETH"` ]]; then
              netdevice=$ETH
              answereth=y
          else
            echo
            echo "\"$ETH\" doesn't exist."
            echo
          fi
      done
      sync
      echo
      echo "Configuring \"kvm-bridge\""
      echo
      printf "Description=\"Bridge Interface br10 : %s, virbr0\"\n" "$netdevice"| sudo tee /etc/netctl/kvm-bridge
      printf "Interface=br10\n" | sudo tee -a /etc/netctl/kvm-bridge
      printf "Connection=bridge\n" | sudo tee -a /etc/netctl/kvm-bridge
      printf "BindsToInterfaces=(%s virbr0)\n" "$netdevice" | sudo tee -a /etc/netctl/kvm-bridge
      printf "IP=dhcp\n" | sudo tee -a /etc/netctl/kvm-bridge
      sync
      printf "<network>\n" | tee "$HOME"/bridged-network.xml
      printf "  <name>br10</name>\n" | tee -a "$HOME"/bridged-network.xml
      printf "  <forward mode=\"nat\">\n" | tee -a "$HOME"/bridged-network.xml
      printf "    <nat>\n" | tee -a "$HOME"/bridged-network.xml
      printf "      <port start=\"1024\" end=\"65535\"/>\n" | tee -a "$HOME"/bridged-network.xml
      printf "    </nat>\n" | tee -a "$HOME"/bridged-network.xml
      printf "  </forward>\n" | tee -a "$HOME"/bridged-network.xml
      printf "  <bridge name=\"virbr1\" stp=\"on\" delay=\"0\"/>\n" | tee -a "$HOME"/bridged-network.xml
      printf "  <domain name=\"br10\"/>\n" | tee -a "$HOME"/bridged-network.xml
      printf "  <ip address=\"192.168.100.1\" netmask=\"255.255.255.0\">\n" | tee -a "$HOME"/bridged-network.xml
      printf "    <dhcp>\n" | tee -a "$HOME"/bridged-network.xml
      printf "      <range start=\"192.168.100.2\" end=\"192.168.100.254\"/>\n" | tee -a "$HOME"/bridged-network.xml
      printf "    </dhcp>\n" | tee -a "$HOME"/bridged-network.xml
      printf "  </ip>\n" | tee -a "$HOME"/bridged-network.xml
      printf "</network>" | tee -a "$HOME"/bridged-network.xml
      sync
      printf "\nallow virbr0\n" | sudo tee -a /etc/qemu/bridge.conf
      printf "allow br10\n" | sudo tee -a /etc/qemu/bridge.conf
      echo
      echo "Defining Virtual Network"
      echo
      sudo virsh net-define "$HOME"/bridged-network.xml
      sync
      echo
      echo "Starting Virtual Network"
      echo
      sudo virsh net-start br10
      sync
      echo
      echo "Making Virtual Network start at boot"
      echo
      sudo virsh net-autostart br10
      sync
      echo
      echo "Disabling $netdevice"
      echo
      sudo ip link set "$netdevice" down
      sleep 5s
      sync
      echo
      echo "Applying sysctl changes"
      echo
      sudo sysctl --system
      sync
      echo
      echo "Starting kvm-bridge"
      echo
      sudo netctl start kvm-bridge
      sync
      sudo nmcli con mod br10 connection.autoconnect yes
      sudo nmcli con reload
      echo
      echo "Enabling kvm-bridge"
      echo
      # sudo systemctl enable netctl-auto@kvm-bridge.service
      sudo netctl enable kvm-bridge
      sudo systemctl daemon-reload
      sleep 1s

      sudo systemctl disable NetworkManager-wait-online.service
      sudo systemctl mask NetworkManager-wait-online.service

      echo
      echo
      echo "Done"
      echo
      echo
      echo "Disable your connection from auto connecting"
      echo "Go to System Settings->Connections->$netdevice click on \"General Configuration\" tab and uncheck \"Connect Automatically with priority\""
      echo
      echo
      echo "Click on the configuration button on the bottom left corner of this screen and enable \"Show virtual connections\" the click \"Ok\""
      echo
      echo
      echo "After that click on \"br10\" and \"General Configuration\" tab, check \"Connect automatically with priotity\" and type \"-100\""
      echo "Then click on \"Bridge\" tab, select \"$netdevice (802-3-ethernet)\" and click on \"Edit\""
      echo "Click the \"General Configuration\" tab, check \"Connect automatically with priotity\" and type \"-100\""
      echo "Save and apply all changes"
      echo
      echo
      echo "If you're having trouble applying changes"
      echo "Run \"sudo netctl stop kvm-bridge\" and then \"sudo netctl start kvm-bridge\""
      echo "You should now be able to make the changes mentioned above"
      echo
      echo "Press any button when you're done"
      echo
      read ANYBUTTON
      sleep 1s
      echo
      echo
      echo "To use the bridged network in your VM create a new NIC or Edit existing"
      echo
      echo
      echo "\"Network source:\" select \"Bridge device...\""
      echo "\"Device Name:\" must be \"br10\""
      echo "\"Device model:\" choose \"virtio\""
      echo
      echo
      echo "If the NIC MAC address doesn't match the MAC address of the network copy-paste it"
      echo "Open Virtual Machine Manager click on Edit->Connection Details, click on \"br10\" and click on \"XML\" tab"
      echo "Copy the \"mac address\" to your VM NIC's mac address"
      echo
      echo
      echo "Press any key when you're done"
      echo
      read ANYKEYDONE
      sleep 1s
else
    sudo netctl start kvm-bridge
fi

sleep 1s
echo
echo "Done."
echo
echo "Note, after these changes, the loading screen before the login screen will take much longer, around 3 minutes"
echo "This is permanent, it'll happen everytime you boot/reboot"
echo "Probably be cause it's trying to connect to the internet and waits 3 mins to give up trying"
echo
sleep 1s
echo
echo "Press Y to reboot now or any key if you plan to manually reboot later."
echo
read REBOOT
if [ "${REBOOT,,}" = y ]; then
    systemctl reboot
fi
exit 0
