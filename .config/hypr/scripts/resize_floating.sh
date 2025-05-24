#!/bin/bash

floating=$(hyprctl activewindow -j | jq '.floating')
window=$(hyprctl activewindow -j | jq '.initialClass' | tr -d "\"")

function toggle() {
  width=$1
  height=$2

  hyprctl --batch "dispatch togglefloating; dispatch resizeactive exact ${width} ${height}; dispatch centerwindow; dispatch moveactive 0 0"
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
virt-manager) handle 1906 1066 ;;
zapzap) handle 1906 1066 ;;
kitty_term) handle 1906 1066 ;;
kitty_code) handle 1066 1906 ;;
spotify_player) handle 1906 1066 ;;
*) handle "80%" "75%" ;;
esac
