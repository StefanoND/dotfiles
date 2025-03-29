#!/usr/bin/env bash

# Catppuccin GTK theme: Current Maintainer
# https://github.com/iruzo/gtk

if ! [ "$EUID" -ne 0 ]; then
  echo
  echo "Don't run this script as root."
  echo
  sleep 1s
  exit 1
fi

cpath="$PWD"

# PACMAN
PKGS=(
  # Dependencies
  'wget'
  'sed'
  'unzip'
  'lookandfeeltool'

  # Portals
  'xdg-desktop-portal-kde'
  'xdg-desktop-portal-gtk'

  # QT and GTK
  'qt5-wayland'
  'qt6-wayland'
  'qt5ct'
  'kvantum'
  'kvantum-qt5'
  'gnome-tweaks'
  'dconf-editor'

  # SDDM
  'sddm-kcm'
  'plasma-framework5'
  'layer-shell-qt'
  'layer-shell-qt5'
  'qt5-quickcontrols'
  'qt5-quickcontrols2'
  'qt6-virtualkeyboard'

  # Needed for some apps
  'xorg-xhost'

  # File Manager (GUI)
  'archlinux-xdg-menu'
  'dolphin'                  # File Manager
  'dolphin-plugins'          # Git, Mercurial and Dropbox support
  'kompare'                  # Adds 'Compare Files' dialog
  'kdegraphics-thumbnailers' # File preview support for Image, PDFs and Blender files
  'kimageformats'            # File preview support for Gimp's .xcf files
  'kimageformats5'           # File preview support for Gimp's .xcf files
  'libheif'                  # File preview support for Gimp's .heic files
  'jxrlib'                   # File preview support for jpegxr .jxr files
  'qt5-imageformats'         # File preview support for .webp, .tiff, .tga and .jp2 files
  'qt6-imageformats'         # File preview support for .webp, .tiff, .tga and .jp2 files
  'ffmpegthumbs'             # File preview support for Video Files (based on ffmpeg)
  'kdesdk-thumbnailers'      # Plugins for the thumbnailing system
  'taglib'                   # Audio files
  'icoutils'                 # Extracts/Convers from/to M$ icon and cursor files (also adds file preview support for .ico, .cur and embedded .exe files)
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | sudo pacman -S "$PKG" --needed
  sync
  sleep 1s
done

# Baloo's KDE's file indexer and searcher. It's useless in hyprland
balooctl6 disable

sudo pacman -Rdd gtk2 --noconfirm

paru -S gtk2-patched-filechooser-icon-view --noconfirm --needed --sudoloop

sudo pacman -Rdd gtk3 --noconfirm

paru -S gtk3-patched-filechooser-icon-view --noconfirm --needed --sudoloop

# PARU
PKGPARU=(
  'qt6ct-kde'

  # Themes
  'papirus-icon-theme-git'
  'papirus-folders-catppuccin-git'
  'kvantum-theme-catppuccin-git'
  'catppuccin-cursors-mocha'

  'qt5-styleplugins'
  'qt6gtk2'

  # File Manager
  'resvg'               # Fast and Accurate preview of SVG images
  'raw-thumbnailer'     # File preview support for .raw files
  'kde-thumbnailer-apk' # File preview support for Android Package files
)

for PKG in "${PKGPARU[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  paru -S "$PKG" --noconfirm --needed --sudoloop
  sync
  sleep 1s
done

./Catppuccin-KDE/install.sh

echo
echo "Run kvantummanager, click on 'Select a Kvantum them folder' and select the 'Catppuccin-Mocha-Mauve'"
echo "folder then click 'Install this theme', then go to the 'Change/Delete Theme' tab and"
echo "select 'catppuccin-mocha-mauve' then click on 'Use this theme'"
echo
echo "Press any key when you're done"
echo

read anything

if [ -f "$HOME"/.gtkrc-2.0 ]; then
  mv "$HOME"/.gtkrc-2.0 "$HOME"/dotfiles/backup/
  sync
fi
cp "$cpath"/.gtkrc-2.0 "$HOME"/

if [ -f "$HOME"/.config/gtk-3.0/settings.ini ]; then
  if ! [ -d "$HOME"/dotfiles/backup/.config/gtk-3.0 ]; then
    mkdir -p "$HOME"/dotfiles/backup/.config/gtk-3.0
  fi
  mv "$HOME"/.config/gtk-3.0/settings.ini "$HOME"/dotfiles/backup/.config/gtk-3.0
  sync
fi
cp "$cpath"/gtk-3.0/settings.ini "$HOME"/.config/gtk-3.0

if [ -f "$HOME"/.config/gtk-4.0/settings.ini ]; then
  if ! [ -d "$HOME"/dotfiles/backup/.config/gtk-4.0 ]; then
    mkdir -p "$HOME"/dotfiles/backup/.config/gtk-4.0
  fi
  mv "$HOME"/.config/gtk-4.0/settings.ini "$HOME"/dotfiles/backup/.config/gtk-4.0
  sync
fi
cp "$cpath"/gtk-4.0/settings.ini "$HOME"/.config/gtk-4.0

if [ -f "$HOME"/.config/qt5ct/qt5ct.conf ]; then
  if ! [ -d "$HOME"/dotfiles/backup/.config/qt5ct ]; then
    mkdir -p "$HOME"/dotfiles/backup/.config/qt5ct
  fi
  mv "$HOME"/.config/qt5ct/qt5ct.conf "$HOME"/dotfiles/backup/.config/qt5ct
  sync
fi
cp "$cpath"/qt5ct/qt5ct.conf "$HOME"/.config/qt5ct

if [ -f "$HOME"/.config/qt5ct/colors/catppuccin-mocha-mauve.conf ]; then
  if ! [ -d "$HOME"/dotfiles/backup/.config/qt5ct/colors ]; then
    mkdir -p "$HOME"/dotfiles/backup/.config/qt5ct/colors
  fi
  mv "$HOME"/.config/qt5ct/colors/catppuccin-mocha-mauve.conf "$HOME"/dotfiles/backup/.config/qt5ct/colors
  sync
fi
cp "$cpath"/qt5ct/colors/catppuccin-mocha-mauve.conf "$HOME"/.config/qt5ct/colors

if [ -f "$HOME"/.config/qt6ct/qt6ct.conf ]; then
  if ! [ -d "$HOME"/dotfiles/backup/.config/qt6ct ]; then
    mkdir -p "$HOME"/dotfiles/backup/.config/qt6ct
  fi
  mv "$HOME"/.config/qt6ct/qt6ct.conf "$HOME"/dotfiles/backup/.config/qt6ct
  sync
fi
cp "$cpath"/qt6ct/qt6ct.conf "$HOME"/.config/qt6ct

if [ -f "$HOME"/.config/qt6ct/colors/catppuccin-mocha-mauve.conf ]; then
  if ! [ -d "$HOME"/dotfiles/backup/.config/qt6ct/colors ]; then
    mkdir -p "$HOME"/dotfiles/backup/.config/qt6ct/colors
  fi
  mv "$HOME"/.config/qt6ct/colors/catppuccin-mocha-mauve.conf "$HOME"/dotfiles/backup/.config/qt6ct/colors
  sync
fi
cp "$cpath"/qt6ct/colors/catppuccin-mocha-mauve.conf "$HOME"/.config/qt6ct/colors/

if ! [ -d "$HOME"/.config/btop/themes ]; then
  mkdir -p "$HOME"/.config/btop/themes
  sync
fi
cp "$cpath"/btop/catppuccin_mocha.theme "$HOME"/.config/btop/themes/

sudo cp -urf "$HOME"/.gtkrc-2.0 /etc/gtk-2.0/gtkrc
sudo cp -urf "$HOME"/.config/gtk-3.0/settings.ini /etc/gtk-3.0/settings.ini

if ! [ -d "$HOME"/.config/xdg-desktop-portal ]; then
  mkdir "$HOME"/.config/xdg-desktop-portal
  sync
fi

printf "[preferred]\ndefault=kde;hyprland" >"$HOME"/.config/xdg-desktop-portal/hyprland-portals.conf

sudo sed -i 's/Inherits.*/Inherits=Papirus/g' /usr/share/icons/default/index.theme

sudo cp -ur "$HOME"/dotfiles/uniformlook/GTKTheme/* /usr/share/themes/
sync

cd /usr/share/icons/Papirus/
sudo curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && sudo chmod +x ./papirus-folders
./papirus-folders -C cat-mocha-mauve --theme Papirus
./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
./papirus-folders -C cat-mocha-mauve --theme Papirus-Light
sync

# Not needed if not using flatpaks
#
if [ -d "$HOME"/.fonts ]; then
  mv "$HOME"/.fonts "$HOME"/dotfiles/backup/
  sync
fi

if [ -d "$HOME"/.icons ]; then
  mv "$HOME"/.icons "$HOME"/dotfiles/backup/
  sync
fi

if [ -d "$HOME"/.themes ]; then
  mv "$HOME"/.themes "$HOME"/dotfiles/backup/
  sync
fi

cp -ur /usr/share/fonts "$HOME"/.fonts
cp -ur /usr/share/icons "$HOME"/.icons
cp -ur /usr/share/themes "$HOME"/.themes
cp -ur /usr/share/fonts "$HOME"/.local/share/
cp -ur /usr/share/icons "$HOME"/.local/share/
cp -ur /usr/share/themes "$HOME"/.local/share/
sync

if ! [ -d "$HOME"/.config/gtk-2.0 ]; then
  mkdir -p "$HOME"/.config/gtk-2.0
  sync
fi

cp -urf "$HOME"/.themes/Catppuccin-Dark/gtk-2.0/* "$HOME"/.config/gtk-2.0/
cp -urf "$HOME"/.themes/Catppuccin-Dark/gtk-3.0/* "$HOME"/.config/gtk-3.0/
cp -urf "$HOME"/.themes/Catppuccin-Dark/gtk-4.0/* "$HOME"/.config/gtk-4.0/
sync

sudo cp -r "$cpath"/sddm/dracula /usr/share/sddm/themes/

sudo mkdir -p /etc/sddm.conf.d
sync
sudo cp -r "$cpath"/sddm/sddm.conf /etc/
sudo mv /etc/sddm.conf /etc/sddm.conf.old
sudo cp -r "$cpath"/sddm/kde_settings.conf /etc/sddm.conf.d/
sync

cd "$cpath"/sddm
sudo make install

localectl set-x11-keymap pt
localectl set-keymap pt-latin1
setxkbmap pt

printf "\nlocalectl set-x11-keymap pt\nlocalectl set-keymap pt-latin1\nsetxkbmap pt\n" | sudo tee -a /usr/share/sddm/scripts/Xsetup
printf "\nxrandr --output DP-1 --primary --output DVI-D-1 --right-of DP-1 --output HDMI-A-1 --left-of DP-1\n" | sudo tee -a /usr/share/sddm/scripts/Xsetup

if [ -f /usr/share/applications/mimeinfo.cache ]; then
  sudo sed -i 's/inode\/directory=.*/inode\/directory=org.kde.dolphin.desktop;/g' /usr/share/applications/mimeinfo.cache
fi

if ! [ -f "$HOME"/.config/mimeapps.list ]; then
  printf "[Default Applications]\ninode\/directory=org.kde.dolphin.desktop\n" >"$HOME"/.config/mimeapps.list
else
  sudo -i 's/inode\/directory=.*/inode\/directory=org.kde.dolphin.desktop/g' "$HOME"/.config/mimeapps.list
fi

if ! xdg-mime query default inode/directory | grep -iq "dolphin"; then
  xdg-mime default org.kde.dolphin.desktop inode/directory
fi

XDG_MENU_PREFIX=arch- kbuildsycoca6

fc-cache --force

# I'm using Wayland so no need for these
# echo 'Xcursor.theme: Catppuccin-Mocha-Mauve-Cursors' | tee -a "$HOME"/.Xresources
# echo 'Xcursor.size: 48' | tee -a "$HOME"/.Xresources
#
# echo 'xset r rate 300 60' | tee -a "$HOME"/.xinitrc
# echo 'xrdb ~/.Xresources' | tee -a "$HOME"/.xinitrc

# Hyprland cursors behaves differently I guess, that's why I'm using size 48
# https://wiki.hyprland.org/Hypr-Ecosystem/hyprcursor/

export QT_CURSOR_SIZE=36
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM=wayland:xcb
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK2_RC_FILES=/home/archuser/.gtkrc-2.0
export HYPRCURSOR_THEME=catppuccin-mocha-mauve-cursors
export HYPRCURSOR_SIZE=48
export XCURSOR_THEME=catppuccin-mocha-mauve-cursors
export XCURSOR_SIZE=36
export GTK_THEME=Catppuccin-Dark
# export GDK_BACKEND="wayland:x11:*" # Don't use this, breaks apps

printf "QT_CURSOR_SIZE=36\n" | sudo tee -a /etc/environment
printf "QT_AUTO_SCREEN_SCALE_FACTOR=1\n" | sudo tee -a /etc/environment
printf "QT_QPA_PLATFORM=wayland:xcb\n" | sudo tee -a /etc/environment
printf "QT_QPA_PLATFORMTHEME=qt5ct\n" | sudo tee -a /etc/environment
# printf "QT_STYLE_OVERRIDE=kvantum\n" | sudo tee -a /etc/environment
printf "GTK2_RC_FILES=/home/archuser/.gtkrc-2.0\n" | sudo tee -a /etc/environment
printf "HYPRCURSOR_THEME=catppuccin-mocha-mauve-cursors\n" | sudo tee -a /etc/environment
printf "HYPRCURSOR_SIZE=48\n" | sudo tee -a /etc/environment
printf "XCURSOR_THEME=catppuccin-mocha-mauve-cursors\n" | sudo tee -a /etc/environment
printf "XCURSOR_SIZE=36\n" | sudo tee -a /etc/environment
printf "GTK_THEME=Catppuccin-Dark\n" | sudo tee -a /etc/environment
# printf "GDK_BACKEND=wayland:x11:*\n" | sudo tee -a /etc/environment # Don't use this, breaks apps
printf "XDG_MENU_PREFIX=arch-\n" | sudo tee -a /etc/environment
# printf "GSK_RENDERER=gl\n" | sudo tee -a /etc/environment
# printf "GDK_DEBUG=gl-no-fractional\n" | sudo tee -a /etc/environment
# printf "NO_AT_BRIDGE=1\n" | sudo tee -a /etc/environment

# Add these to Hyprland
# # Gtk Theme workaround
# exec = gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Dark
# exec = gsettings set org.gnome.desktop.interface icon-theme Papirus
# exec = gsettings set org.gnome.desktop.interface font-name Inter 11
# exec = gsettings set org.gnome.desktop.interface cursor-theme catppuccin-mocha-mauve-cursors
# exec = hyprctl setcursor catppuccin-mocha-mauve-cursors 36

# Note "env" sets envvars for current session;
#      "envd" sets envvars for the D-Bus AND exports to the session (systemd only)

# # Add these Hyprland Environment Variables
# envd = HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors
# envd = HYPRCURSOR_SIZE,36
# envd = XCURSOR_THEME,catppuccin-mocha-mauve-cursors
# envd = XCURSOR_SIZE,36
# envd = QT_CURSOR_SIZE,36
# envd = QT_AUTO_SCREEN_SCALE_FACTOR,1
# envd = QT_QPA_PLATFORM,wayland;xcb
# envd = QT_QPA_PLATFORMTHEME,qt5ct
# envd = GTK2_RC_FILES,/home/archuser/.gtkrc-2.0
# envd = GTK_THEME,Catppuccin-Dark
# envd = GDK_BACKEND,wayland,x11,*
# envd = XDG_MENU_PREFIX,arch-

echo
echo "Some apps that gives 'Auth required but no auth protocol specified' or 'Cannot open display' errors"
echo "Must be run with 'sudo -E'"
echo
echo "Or you can install 'xorg-xhost' but it won't have the theme applied"
echo
sleep 1s

echo
echo "Done..."
echo
sleep 1s
echo
echo "Press Y to reboot now or N if you plan to manually reboot later."
echo
read REBOOT
if [ "${REBOOT,,}" = y ]; then
  reboot
fi

exit 0
