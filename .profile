# Default config home
export XDG_CONFIG_HOME=$HOME/.config

# Terminal
export TERM=xterm-256color

export PATH=".local/bin/bear:$PATH"
export PIPEWIRE_LATENCY="64/48000"

# Themeing
export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
# export QT_STYLE_OVERRIDE=kvantum
export GTK2_RC_FILES=/home/archuser/.gtkrc-2.0
export XCURSOR_THEME=catppuccin-mocha-mauve-cursors
export XCURSOR_SIZE=48
export GTK_THEME=Catppuccin-Dark
export NO_AT_BRIDGE=1
export GSK_RENDERER=gl
export GDK_DEBUG=gl-no-fractional
# export GTK_USE_PORTAL=1
# export GDK_DEBUG=portals
# export XDG_DESKTOP_PORTAL=1

# text editor
export SUDO_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

#browser
export BROWSER=brave

#terminal
export TERM=kitty

#mail
export MAIL='flatpak run org.mozilla.Thunderbird'

# Dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT=$HOME/.dotnet
