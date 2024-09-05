#!/usr/bin/env bash

# # Terminate already running bar instances
# # If all your bars have ipc enabled, you can use
# # polybar-msg cmd quit
# # Otherwise you can use the nuclear option:
killall -q polybar
sync

if grep -q '; include-file = ~/.config/polybar/wideconfig.ini' "$HOME"/.config/polybar/config.ini; then
  if grep -q '; include-file = ~/.config/polybar/tripleconfig.ini' "$HOME"/.config/polybar/config.ini; then
    sync
  else
    killall -q polybar
    sync
    echo "---" | tee -a /tmp/polybar2.log
    echo "---" | tee -a /tmp/polybar1.log
    echo "---" | tee -a /tmp/polybar3.log
    sync
    polybar left | tee -a /tmp/polybar2.log & disown
    polybar bar | tee -a /tmp/polybar1.log & disown
    polybar right | tee -a /tmp/polybar3.log & disown
    sync
  fi
else
  if grep -q '; include-file = ~/.config/polybar/tripleconfig.ini' "$HOME"/.config/polybar/config.ini; then
    killall -q polybar
    sync
    echo "---" | tee -a /tmp/polybar1.log
    sync
    polybar bar | tee -a /tmp/polybar1.log & disown
    sync
  fi
fi
