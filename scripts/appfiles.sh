#!/usr/bin/env bash
#
# Description of the script.

if ! xdg-mime query default inode/directory | grep -iq "dolphin"; then
  xdg-mime default org.kde.dolphin.desktop inode/directory
fi

if ! grep -q 'org.kde.dolphin.desktop' /usr/share/applications/mimeinfo.cache; then
  DOLPHININODE="$(cat /usr/share/applications/mimeinfo.cache | grep "inode\/directory" | rev | cut -c 1- | rev)"
  DOLPHININODE+=org.kde.dolphin.desktop;

  sudo sed -ie "s|^inode\/directory.*|${DOLPHININODE}|g" /usr/share/applications/mimeinfo.cache
fi

# XDG_MENU_PREFIX=arch- kbuildsycoca6
export XDG_MENU_PREFIX=plasma- && kbuildsycoca6

exit 0
