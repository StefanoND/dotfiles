#!/usr/bin/env bash
#
# Description of the script.

if ! ps lx | ugrep 'kitty_code' | ugrep 'S<l'; then
  kitty --class=kitty_code
fi
