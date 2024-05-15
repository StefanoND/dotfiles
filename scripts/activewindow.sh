#!/usr/bin/env bash

# Detect current active Class name and Window name
# Autodetects X11 or Wayland

istrue=y

isWayland=`loginctl show-session "$(loginctl | grep "$(whoami)" | awk '{print $1}')" -p Type`

if [[ $isWayland == *"wayland"* ]]; then
  while [[ ${istrue,,} = y ]]; do
    classname=`hyprctl activewindow -j | jq -r ".class"`
    windowname=`hyprctl activewindow -j | jq -r ".title"`
    echo
    echo "Detecting active Window"
    echo
    echo "--------------------------"
    echo "|         Active         |"
    echo "--------------------------"
    echo
    printf "Class: $classname"
    echo
    echo
    printf "Window: $windowname"
    echo
    echo
    echo "--------------------------"
    echo
    sleep 1s
  done
else
  while [[ ${istrue,,} = y ]]; do
    classname=`xdotool getactivewindow getwindowclassname`
    windowname=`xdotool getactivewindow getwindowname`
    echo
    echo "Detecting active Window"
    echo
    echo "--------------------------"
    echo "|         Active         |"
    echo "--------------------------"
    echo
    printf "Class: $classname"
    echo
    echo
    printf "Window: $windowname"
    echo
    echo
    echo "--------------------------"
    echo
    sleep 1s
  done
fi

exit 0
