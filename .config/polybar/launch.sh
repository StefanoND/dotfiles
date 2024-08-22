#!/usr/bin/env bash

# # Terminate already running bar instances
# # If all your bars have ipc enabled, you can use
# # polybar-msg cmd quit
# # Otherwise you can use the nuclear option:
killall -q polybar
#
# # Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar2.log
echo "---" | tee -a /tmp/polybar1.log
echo "---" | tee -a /tmp/polybar3.log
polybar left | tee -a /tmp/polybar2.log & disown
polybar bar | tee -a /tmp/polybar1.log & disown
polybar right | tee -a /tmp/polybar3.log & disown
