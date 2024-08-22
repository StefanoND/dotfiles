# Default config home
export XDG_CONFIG_HOME=$HOME/.config

# Terminal
export TERM=xterm-256color

export PATH=".local/bin/bear:$PATH"
export PIPEWIRE_LATENCY="64/48000"

# Themeing
export QT_QPA_PLATFORMTHEME=qt6
export GTK2_RC_FILES=/home/archuser/.gtkrc-2.0
export XCURSOR_THEME=Catppuccin-Mocha-Mauve-Cursors
export XCURSOR_SIZE=48
export GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark

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
