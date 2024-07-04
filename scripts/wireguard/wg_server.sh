#!/usr/bin/env bash
#
# Description of the script.

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

NICNAME=''
IPADD=''

ip a

echo
echo "Write down your NIC Name (should be enpXs0) and your (inet) IP Adress (should be 192.168.x.x)"
echo

sudo apt install wireguard net-tools iptables -y
sync

sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sync

wg genkey | sudo tee /etc/wireguard/privatekey | wg pubkey | sudo tee /etc/wireguard/publickey

PRIVATEKEY=$(sudo cat /etc/wireguard/privatekey)
PUBLICKEY=$(sudo cat /etc/wireguard/publickey)

sudo cp "$PWD"/wireguard/wg_server_template.conf /etc/wireguard/wg0.conf
sync

sudo sed -i "s/###YourPrivateKey/$PRIVATEKEY/g" /etc/wireguard/wg0.conf
sudo sed -i "s/###Your_Network_Interface_Name/$NICNAME/g" /etc/wireguard/wg0.conf

sudo chmod 600 /etc/wireguard/wg0.conf
sudo chmod 600 /etc/wireguard/privatekey

sudo systemctl enable --now wg-quick@wg0

sudo ufw enable
sudo ufw allow 51420/udp
sudo ufw allow 22/tcp
sudo ufw reload

echo
printf "When setting up the client these are the information you'll need for them:\n"
printf "Server's Publick Key: %s" "$PUBLICKEY"
printf "Server's IP Address: %s" "$IPADD"
echo

exit 0
