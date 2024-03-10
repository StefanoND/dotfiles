#!/bin/bash

if ! "$(pacman -Q | grep -i wmctrl)"; then
  sudo pacman -S wmctrl --noconfirm --needed
fi

if ! "$(pacman -Q | grep -i i3-msg)"; then
  sudo pacman -S i3-msg --noconfirm --needed
fi

runcmd="$1"
wmclass="$2"

function switch() {
    wmctrl -xa "$wmclass"
}

if ! switch; then
    eval "$runcmd" &
    while ! switch; do sleep 0.1; done
fi
