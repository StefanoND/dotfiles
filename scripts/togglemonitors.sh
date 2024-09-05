#!/usr/bin/env bash
#
# Description of the script.

if ! xrandr --listmonitors | grep -iq 'StSurround'; then
  xrandr --setmonitor StSurround auto HDMI-A-0,DisplayPort-0,DisplayPort-1
  sync
  sed -i "s/# include \$HOME\/dotfiles\/.config\/i3\/settings\/wideworkspaces.conf/include \$HOME\/dotfiles\/.config\/i3\/settings\/wideworkspaces.conf/g" "$HOME"/dotfiles/.config/i3/config
  sync
  sed -i "s/include \$HOME\/dotfiles\/.config\/i3\/settings\/tripleworkspaces.conf/# include \$HOME\/dotfiles\/.config\/i3\/settings\/tripleworkspaces.conf/g" "$HOME"/dotfiles/.config/i3/config
  sync
  sed -i "s/# include \$HOME\/dotfiles\/.config\/i3\/settings\/widemonitor.conf/include \$HOME\/dotfiles\/.config\/i3\/settings\/widemonitor.conf/g" "$HOME"/dotfiles/.config/i3/config
  sync
  sed -i "s/include \$HOME\/dotfiles\/.config\/i3\/settings\/triplemonitor.conf/# include \$HOME\/dotfiles\/.config\/i3\/settings\/triplemonitor.conf/g" "$HOME"/dotfiles/.config/i3/config
  sync
  sed -i "s/; include-file = ~\/.config\/polybar\/wideconfig.ini/include-file = ~\/.config\/polybar\/wideconfig.ini/g" "$HOME"/dotfiles/.config/polybar/config.ini
  sync
  sed -i "s/include-file = ~\/.config\/polybar\/tripleconfig.ini/; include-file = ~\/.config\/polybar\/tripleconfig.ini/g" "$HOME"/dotfiles/.config/polybar/config.ini
  sync
  i3 restart
  sync
  notify-send 'Surround enabled' &
  sync
else
  xrandr --delmonitor StSurround && xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144 --output HDMI-A-0 --mode 1920x1080 --rate 50 --left-of DisplayPort-0 --output DisplayPort-1 --mode 1920x1080 --rate 50 --right-of DisplayPort-0
  sync
  sed -i "s/include \$HOME\/dotfiles\/.config\/i3\/settings\/wideworkspaces.conf/# include \$HOME\/dotfiles\/.config\/i3\/settings\/wideworkspaces.conf/g" "$HOME"/dotfiles/.config/i3/config
  sync
  sed -i "s/# include \$HOME\/dotfiles\/.config\/i3\/settings\/tripleworkspaces.conf/include \$HOME\/dotfiles\/.config\/i3\/settings\/tripleworkspaces.conf/g" "$HOME"/dotfiles/.config/i3/config
  sync
  sed -i "s/include \$HOME\/dotfiles\/.config\/i3\/settings\/widemonitor.conf/# include \$HOME\/dotfiles\/.config\/i3\/settings\/widemonitor.conf/g" "$HOME"/dotfiles/.config/i3/config
  sync
  sed -i "s/# include \$HOME\/dotfiles\/.config\/i3\/settings\/triplemonitor.conf/include \$HOME\/dotfiles\/.config\/i3\/settings\/triplemonitor.conf/g" "$HOME"/dotfiles/.config/i3/config
  sync
  sed -i "s/include-file = ~\/.config\/polybar\/wideconfig.ini/; include-file = ~\/.config\/polybar\/wideconfig.ini/g" "$HOME"/dotfiles/.config/polybar/config.ini
  sync
  sed -i "s/; include-file = ~\/.config\/polybar\/tripleconfig.ini/include-file = ~\/.config\/polybar\/tripleconfig.ini/g" "$HOME"/dotfiles/.config/polybar/config.ini
  sync
  i3 restart
  sync
  notify-send 'Surround disabled' &
  sync
fi
