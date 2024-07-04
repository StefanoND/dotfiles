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

yes | sudo pacman -S wireguard --needed

wg genkey | sudo tee /etc/wireguard/privatekey | wg pubkey | sudo tee /etc/wireguard/publickey

sudo cp "$PWD"/wireguard/wg_client_template.conf /etc/wireguard/wg0.conf

PRIVATEKEY=$(sudo cat /etc/wireguard/privatekey)
ADDRESS='10.20.0.10/32'
PUBLICKEY=''
ENDPOINT=''
ALLOWEDIPS='0.0.0.0/0'

PUBLICKEY=$(sudo cat /etc/wireguard/publickey)

echo
echo "Paste the following commands into the WireGuard's server"
printf "wg set wg0 peer %s allowed-ips %s && wg-quick save wg0\n" "$PUBLICKEY" "$ADDRESS"
echo
echo "When you're done use the following command to connect:"
echo "wg-quick up wg0"
echo
echo "And use the following command to disconnect:"
echo "wg-quick down wg0"
echo

exit 0
