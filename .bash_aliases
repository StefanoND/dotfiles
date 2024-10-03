#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Sudo preserving user's envvars
alias sude='sudo -E'

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Show open ports
alias openports='netstat -nape --inet'

# Update system instead of manually typing
# alias updatesystem='sudo pacman -Syy && paru -Su --noconfirm --needed --sudoloop && flatpak update -y && sudo mkinitcpio -P'
alias updatesystem='sudo pacman -Syy && paru -Su --noconfirm --needed --sudoloop && flatpak update -y && sudo update-grub'

# Clear cache
alias clear-cache='sudo paccache -r && paru -Sccd'

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# Edit this .bash files
alias ebrc='edit ~/.bashrc'
alias ebal='edit ~/.bash_aliases'

# alias to show the date
alias da='date "+%d/%m/%Y %A %T %Z"'

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Remove a directory and all files
alias rmd='/bin/rm -rv '
alias rmdir='/bin/rm -rv '
alias rmdf='/bin/rm -rfv '
alias rmdirf='/bin/rm -rfv '
alias rmdirforce='/bin/rm -rfv '

# Alias's to modified commands
alias cp='cp -iv'
alias cpf='cp -fv'
alias mv='mv -iv'
alias mvf='mv -fv'
alias mkdir='mkdir -p'
alias ls='eza -al --color=always --group-directories-first --icons --git'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias vi='nvim'
alias vim='nvim'
alias svi='sudo vi'
# alias sudo='sudo -v; sudo '

# Replace ls with eza
alias la='eza -a --color=always --group-directories-first --icons --git'      # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons --git'      # long format
alias lt='eza -aT --color=always --group-directories-first --icons --git'     # tree listing
alias l.='eza -ald --color=always --group-directories-first --icons --git .*' # show only dotfiles
alias lx='eza -l -s extension'                                                # sort by extension
alias lk='eza -l -s size'                                                     # sort by size
alias lc='eza -l -t modified'                                                 # sort by change time
alias lr='eza -lR'                                                            # recursive ls
alias lt='eza -l -s date'                                                     # sort by date
alias lff="eza -l --group-directories-first"                                  # directories first
alias ldl="eza -l"                                                            # directories last
alias lf="eza -l | egrep -v '^d'"                                             # files only
alias ldir="eza -l | egrep '^d'"                                              # directories only

      # ".Z") uncompress "$archive" ;;

# SHA1
alias sha1='openssl sha1'

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias safereboot='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
alias forcereboot='sudo shutdown -r -n now'

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# alias firefox='firefox -P & disown'
alias firedragon='firedragon -P & disown'
alias thunar='thunar & disown'

# QT's apps
alias dolphin='QT_QPA_PLATFORMTHEME=qt5ct:qt6ct /usr/bin/dolphin & disown'
alias kate='QT_QPA_PLATFORMTHEME=qt5ct:qt6ct /usr/bin/kate & disown'

alias virt-manager='virt-manager & disown'
alias virtualbox='virtualbox & disown'
# alias emacsd='/usr/bin/emacs --daemon'
# alias emacs='emacsclient -c -a emacs & disown'
alias doomemacsd='/usr/bin/emacs --init-directory="~/dotfiles/emacs/doom/doomemacs" --bg-daemon="doom"'
alias doomemacst='emacsclient -c -t -s doom -a doom'
alias doomemacs='emacsclient -c -s doom -a doom & disown'
alias stemacsd='/usr/bin/emacs --init-directory="~/dotfiles/emacs/stemacs/stemacs" --bg-daemon="stemacs"'
alias stemacst='emacsclient -c -t -s stemacs -a stemacs'
alias stemacs='emacsclient -c -s stemacs -a stemacs & disown'
alias godot='nohup godot & disown'
alias sudenvim='sudo -E nvim'
alias zoom='nohup zoom & disown'
alias syncthing='nohup syncthing & disown'
alias yata='nohup gtk-launch yata & disown'
alias codium='nohup codium --password-store="kwallet5" & disown'
alias trash='gio trash'
alias rmt='gio trash'
alias headset-charge-indicator='nohup python3 ~/dotfiles/apps/headset-charge-indicator/headset-charge-indicator.py & disown'
alias headsetchargeindicator='nohup python3 ~/dotfiles/apps/headset-charge-indicator/headset-charge-indicator.py & disown'

alias waybar='nohup waybar & disown'
alias restartwaybar='killall -9 waybar && sleep 1s && waybar & disown'

# Godot
alias gdnvim="nvim --listen ./godothost"
alias gdvim="nvim --listen ./godothost"
alias godotnvim="nvim --listen ./godothost"
alias godotvim="nvim --listen ./godothost"
alias nvimgodot="nvim --listen ./godothost"
alias vimgodot="nvim --listen ./godothost"
alias nvimgd="nvim --listen ./godothost"
alias vimgd="nvim --listen ./godothost"

# Monero
# alias monero='monerod --block-sync-size 10 --db-sync-mode fastest:sync:8750'

# Using other command in .bashrc.local
# alias ue4='SDL_VIDEODRIVER=x11 ~/.local/bin/ue4'
# alias ue5='SDL_VIDEODRIVER=x11 ~/.local/bin/ue4'

# Flatpaks
# WINE
# Wine
#& disown'
alias wine='flatpak run org.winehq.Wine & disown'
# alias wine-gecko='flatpak run org.winehq.Wine.gecko & disown'
# alias wine-mono='flatpak run org.winehq.Wine.mono & disown'
alias winetricks='flatpak run --command=winetricks org.winehq.Wine'
alias winecfg='flatpak run --command=winecfg org.winehq.Wine'
alias wineboot='flatpak run --command=wineboot org.winehq.Wine'

# KDE/QT
alias krita='flatpak run org.kde.krita & disown'
alias kleopatra='flatpak run org.kde.kleopatra & disown'
alias okteta='flatpak run org.kde.okteta & disown'

alias flatseal='flatpak run com.github.tchx84.Flatseal & disown'
alias libreoffice='flatpak run org.libreoffice.LibreOffice & disown'
alias office='flatpak run org.libreoffice.LibreOffice & disown'
alias obsidian='flatpak run md.obsidian.Obsidian & disown'
alias telegram='flatpak run org.telegram.desktop & disown'
# alias discord='flatpak run com.discordapp.Discord --enable-features=UseOzonePlatform --ozone-platform=wayland & disown'
alias discord='flatpak run dev.vencord.Vesktop & disown'
alias vesktop='flatpak run dev.vencord.Vesktop & disown'
alias whatsapp='flatpak run com.github.eneshecan.WhatsAppForLinux & disown'
alias qbittorrent='flatpak run org.qbittorrent.qBittorrent & disown'
alias tenacity='flatpak run org.tenacityaudio.Tenacity & disown'
alias obs-studio='flatpak run com.obsproject.Studio & disown'
alias obs='flatpak run com.obsproject.Studio & disown'
alias smplayer='flatpak run info.smplayer.SMPlayer & disown'
alias mpv='flatpak run io.mpv.Mpv & disown'
alias gimp='flatpak run org.gimp.GIMP & disown'
alias inkscape='flatpak run org.inkscape.Inkscape & disown'
alias blender='flatpak run org.blender.Blender & disown'
alias handbrake='flatpak run fr.handbrake.ghb & disown'
alias github-desktop='flatpak run io.github.shiftey.Desktop & disown'
alias github='flatpak run io.github.shiftey.Desktop & disown'
alias unityhub='flatpak run com.unity.UnityHub & disown'
alias steam='flatpak run com.valvesoftware.Steam & disown'
alias lutris='flatpak run net.lutris.Lutris & disown'
alias epicassetmanager='flatpak run io.github.achetagames.epic_asset_manager & disown'
alias eam='flatpak run io.github.achetagames.epic_asset_manager & disown'
alias protonup-qt='flatpak run net.davidotek.pupgui2 & disown'
alias protonup='flatpak run net.davidotek.pupgui2 & disown'
alias antimicrox='flatpak run io.github.antimicrox.antimicrox & disown'
alias protontricks='flatpak run com.github.Matoking.protontricks & disown'
# alias torbrowser-launcher='flatpak run org.torproject.torbrowser-launcher & disown'
# alias torbrowser='flatpak run org.torproject.torbrowser-launcher & disown'
alias torbrowser-launcher='torbrowser-launcher & disown'
alias torbrowser='torbrowser-launcher & disown'
alias mullvadbrowser='flatpak run net.mullvad.MullvadBrowser & disown'
alias firefox='flatpak run org.mozilla.firefox & disown'
# alias spotify='flatpak run com.spotify.Client --enable-features=UseOzonePlatform --ozone-platform=wayland & disown'
alias spotify='nohup spotify & disown'
alias qalculate-qt='flatpak run io.github.Qalculate.qalculate-qt & disown'
alias qalculate='flatpak run io.github.Qalculate.qalculate-qt & disown'
alias gcolor='flatpak run nl.hjdskes.gcolor3 & disown'
alias bitwarden='flatpak run com.bitwarden.desktop & disown'
alias monero='flatpak run org.getmonero.Monero & disown'
alias eclipse='flatpak run org.eclipse.Java & disown'
alias stremio='flatpak run com.stremio.Stremio & disown'
alias brave='QT_QPA_PLATFORMTHEME=qt5ct:qt6ct /usr/bin/brave & disown'
alias bravebrowser='QT_QPA_PLATFORMTHEME=qt5ct:qt6ct /usr/bin/brave & disown'
alias thunderbird='flatpak run org.mozilla.Thunderbird & disown'

alias dosbox-staging='flatpak run io.github.dosbox-staging & disown'
alias dosbox='flatpak run io.github.dosbox-staging & disown'
alias lime3ds='flatpak run io.github.lime3ds.Lime3DS & disown'
alias ryujinx='DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0 flatpak run org.ryujinx.Ryujinx & disown'
alias yuzu='flatpak run org.yuzu_emu.yuzu & disown'
alias citra='flatpak run org.citra_emu.citra & disown'
alias cemu='flatpak run info.cemu.Cemu & disown'
alias duckstation='flatpak run org.duckstation.DuckStation & disown'
alias retroarch='flatpak run org.libretro.RetroArch & disown'
alias n64emu='flatpak run com.github.Rosalie241.RMG & disown'
alias project64='flatpak run com.github.Rosalie241.RMG & disown'
alias dolphin-emu='flatpak run org.DolphinEmu.dolphin-emu & disown'
alias dolphin-emulator='flatpak run org.DolphinEmu.dolphin-emu & disown'
alias PCSX2='flatpak run net.pcsx2.PCSX2 & disown'
alias ps2emu='flatpak run net.pcsx2.PCSX2 & disown'
alias RPCS3='flatpak run net.rpcs3.RPCS3 & disown'
alias ps3emu='flatpak run net.rpcs3.RPCS3 & disown'

alias heroicgameslauncher='flatpak run com.heroicgameslauncher.hgl & disown'
alias heroic='flatpak run com.heroicgameslauncher.hgl & disown'
alias gdlauncher='flatpak run io.gdevs.GDLauncher & disown'
alias playonlinux='flatpak run org.phoenicis.playonlinux & disown'
alias boxes='flatpak run org.gnome.Boxes & disown'
alias gnome-boxes='flatpak run org.gnome.Boxes & disown'
alias bottles='flatpak run com.usebottles.bottles & disown'
alias atoms='flatpak run pm.mirko.Atoms & disown'

alias spice='looking-glass-client -C ~/.config/looking-glass/main.ini'
alias triplewide='xrandr --setmonitor StSurround auto HDMI-A-0,DisplayPort-0,DisplayPort-1'
alias triplenormal='xrandr --delmonitor StSurround && xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144 --output HDMI-A-0 --mode 1920x1080 --rate 50 --left-of DisplayPort-0 --output DisplayPort-1 --mode 1920x1080 --rate 50 --right-of DisplayPort-0'

# alias dosbox-staging='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.dosbox-staging & disown'
# alias dosbox='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.dosbox-staging & disown'
# alias lime3ds='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.lime3ds.Lime3DS & disown'
# alias ryujinx='DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0 gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.ryujinx.Ryujinx & disown'
# alias yuzu='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.yuzu_emu.yuzu & disown'
# alias citra='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.citra_emu.citra & disown'
# alias cemu='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run info.cemu.Cemu & disown'
# alias duckstation='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.duckstation.DuckStation & disown'
# alias retroarch='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.libretro.RetroArch & disown'
# alias n64emu='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.github.Rosalie241.RMG & disown'
# alias project64='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.github.Rosalie241.RMG & disown'
# alias dolphin-emu='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.DolphinEmu.dolphin-emu & disown'
# alias dolphin-emulator='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.DolphinEmu.dolphin-emu & disown'
# alias PCSX2='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.pcsx2.PCSX2 & disown'
# alias ps2emu='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.pcsx2.PCSX2 & disown'
# alias RPCS3='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.rpcs3.RPCS3 & disown'
# alias ps3emu='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.rpcs3.RPCS3 & disown'
#
# alias heroicgameslauncher='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.heroicgameslauncher.hgl & disown'
# alias heroic='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.heroicgameslauncher.hgl & disown'
# alias gdlauncher='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.gdevs.GDLauncher & disown'
# alias wine='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.winehq.Wine & disown'
# # alias wine-gecko='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.winehq.Wine.gecko & disown'
# # alias wine-mono='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.winehq.Wine.mono & disown'
# alias playonlinux='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.phoenicis.playonlinux & disown'
# alias boxes='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.gnome.Boxes & disown'
# alias gnome-boxes='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.gnome.Boxes & disown'
# alias bottles='gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.usebottles.bottles & disown'

# alias ='flatpak run  & disown'
