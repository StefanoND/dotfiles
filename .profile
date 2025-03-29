# Default config home
export XDG_CONFIG_HOME=$HOME/.config

# Terminal
export TERM=xterm-256color

# Pipewire
export PIPEWIRE_LATENCY="1024/48000"

# Themeing
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
# export GDK_BACKEND=wayland:x11:*
export XDG_MENU_PREFIX=arch-

# text editor
export SUDO_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

#browser
export BROWSER=brave

#terminal
export TERM=kitty

#mail
# export MAIL='flatpak run org.mozilla.Thunderbird'

# Dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT=$HOME/.dotnet

. "$HOME/.atuin/bin/env"
