#!/bin/bash

floating=$(hyprctl activewindow -j | jq '.floating')
window=$(hyprctl activewindow -j | jq '.initialClass' | tr -d "\"")

# Custom named kitty and spotify
case $window in
  zapzap) hyprctl dispatch togglefloating
    exit 0 ;;
  kitty_term) hyprctl dispatch togglefloating
    exit 0 ;;
  spotify_player) hyprctl dispatch togglefloating
    exit 0 ;;
esac

function toggle() {
	width=$1
	height=$2

	hyprctl --batch "dispatch togglefloating; dispatch resizeactive exact ${width} ${height}; dispatch centerwindow; dispatch moveactive 1 15"
}

function untoggle() {
	hyprctl dispatch togglefloating
}

function handle() {
	width=$1
	height=$2

	if [ "$floating" == "false" ]; then
		toggle "$width" "$height"
	else
		untoggle
	fi
}

case $window in
virt-manager) handle 1896 1024 ;;
*) handle "80%" "75%" ;;
esac
