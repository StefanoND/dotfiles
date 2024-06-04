#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -f /usr/local/bin/hyprstart ]; then
  exec hyprstart
fi

if [ -f /usr/bin/xdg-mime ]; then
  if ! xdg-mime query default inode/directory | grep -iq "dolphin"; then
    xdg-mime default org.kde.dolphin.desktop inode/directory
  fi
fi
