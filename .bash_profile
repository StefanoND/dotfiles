#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

hyprstart

if ! xdg-mime query default inode/directory | grep -iq "dolphin"; then
  xdg-mime default org.kde.dolphin.desktop inode/directory
fi
