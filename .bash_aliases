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

# alias firefox='cd ~/ && nohup firefox -P &'
alias firedragon='cd ~/ && nohup firedragon -P &'
alias thunar='cd ~/ && nohup thunar &'

# QT's apps
alias dolphin='cd ~/ && QT_QPA_PLATFORMTHEME=qt5ct:qt6ct nohup /usr/bin/dolphin &'
alias kate='cd ~/ && QT_QPA_PLATFORMTHEME=qt5ct:qt6ct nohup /usr/bin/kate &'

alias virt-manager='cd ~/ && nohup virt-manager &'
alias virtualbox='cd ~/ && nohup virtualbox &'
# alias emacsd='/usr/bin/emacs --daemon'
# alias emacs='cd ~/ && nohup emacsclient -c -a emacs &'
alias doomemacsd='/usr/bin/emacs --init-directory="~/dotfiles/emacs/doom/doomemacs" --bg-daemon="doom"'
alias doomemacst='emacsclient -c -t -s doom -a doom'
alias doomemacs='cd ~/ && nohup emacsclient -c -s doom -a doom &'
alias stemacsd='/usr/bin/emacs --init-directory="~/dotfiles/emacs/stemacs/stemacs" --bg-daemon="stemacs"'
alias stemacst='emacsclient -c -t -s stemacs -a stemacs'
alias stemacs='cd ~/ && nohup emacsclient -c -s stemacs -a stemacs &'
alias godot='cd ~/ && nohup godot &'
alias sudenvim='sudo -E nvim'
alias zoom='cd ~/ && nohup zoom &'
alias syncthing='cd ~/ && nohup syncthing &'
alias yata='cd ~/ && nohup gtk-launch yata &'
alias codium='cd ~/ && nohup codium --password-store="kwallet5" &'
alias trash='gio trash'
alias rmt='gio trash'
alias headset-charge-indicator='cd ~/ && nohup python3 ~/dotfiles/apps/headset-charge-indicator/headset-charge-indicator.py &'
alias headsetchargeindicator='cd ~/ && nohup python3 ~/dotfiles/apps/headset-charge-indicator/headset-charge-indicator.py &'

alias waybar='cd ~/ && nohup waybar &'
alias restartwaybar='killall -9 waybar && sleep 1s && cd ~/ && nohup waybar &'

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
alias wine='cd ~/ && nohup flatpak run org.winehq.Wine &'
# alias wine-gecko='cd ~/ && nohup flatpak run org.winehq.Wine.gecko &'
# alias wine-mono='cd ~/ && nohup flatpak run org.winehq.Wine.mono &'
alias winetricks='flatpak run --command=winetricks org.winehq.Wine'
alias winecfg='flatpak run --command=winecfg org.winehq.Wine'
alias wineboot='flatpak run --command=wineboot org.winehq.Wine'

# KDE/QT
alias krita='cd ~/ && nohup flatpak run org.kde.krita &'
alias kleopatra='cd ~/ && nohup flatpak run org.kde.kleopatra &'
alias okteta='cd ~/ && nohup flatpak run org.kde.okteta &'

alias flatseal='cd ~/ && nohup flatpak run com.github.tchx84.Flatseal &'
alias libreoffice='cd ~/ && nohup flatpak run org.libreoffice.LibreOffice &'
alias office='cd ~/ && nohup flatpak run org.libreoffice.LibreOffice &'
alias obsidian='cd ~/ && nohup flatpak run md.obsidian.Obsidian &'
alias telegram='cd ~/ && nohup flatpak run org.telegram.desktop &'
# alias discord='cd ~/ && nohup flatpak run com.discordapp.Discord --enable-features=UseOzonePlatform --ozone-platform=wayland &'
alias discord='cd ~/ && nohup flatpak run dev.vencord.Vesktop &'
alias vesktop='cd ~/ && nohup flatpak run dev.vencord.Vesktop &'
alias whatsapp='cd ~/ && nohup flatpak run com.github.eneshecan.WhatsAppForLinux &'
alias qbittorrent='cd ~/ && nohup flatpak run org.qbittorrent.qBittorrent &'
alias tenacity='cd ~/ && nohup flatpak run org.tenacityaudio.Tenacity &'
alias obs-studio='cd ~/ && nohup flatpak run com.obsproject.Studio &'
alias obs='cd ~/ && nohup flatpak run com.obsproject.Studio &'
alias smplayer='cd ~/ && nohup flatpak run info.smplayer.SMPlayer &'
alias mpv='cd ~/ && nohup flatpak run io.mpv.Mpv &'
alias gimp='cd ~/ && nohup flatpak run org.gimp.GIMP &'
alias inkscape='cd ~/ && nohup flatpak run org.inkscape.Inkscape &'
alias blender='cd ~/ && nohup flatpak run org.blender.Blender &'
alias handbrake='cd ~/ && nohup flatpak run fr.handbrake.ghb &'
alias github-desktop='cd ~/ && nohup flatpak run io.github.shiftey.Desktop &'
alias github='cd ~/ && nohup flatpak run io.github.shiftey.Desktop &'
alias unityhub='cd ~/ && nohup flatpak run com.unity.UnityHub &'
alias steam='cd ~/ && nohup flatpak run com.valvesoftware.Steam &'
alias lutris='cd ~/ && nohup flatpak run net.lutris.Lutris &'
alias epicassetmanager='cd ~/ && nohup flatpak run io.github.achetagames.epic_asset_manager &'
alias eam='cd ~/ && nohup flatpak run io.github.achetagames.epic_asset_manager &'
alias protonup-qt='cd ~/ && nohup flatpak run net.davidotek.pupgui2 &'
alias protonup='cd ~/ && nohup flatpak run net.davidotek.pupgui2 &'
alias antimicrox='cd ~/ && nohup flatpak run io.github.antimicrox.antimicrox &'
alias protontricks='cd ~/ && nohup flatpak run com.github.Matoking.protontricks &'
alias torbrowser-launcher='cd ~/ && nohup flatpak run org.torproject.torbrowser-launcher &'
alias torbrowser='cd ~/ && nohup flatpak run org.torproject.torbrowser-launcher &'
alias mullvadbrowser='cd ~/ && nohup flatpak run net.mullvad.MullvadBrowser &'
alias firefox='cd ~/ && nohup flatpak run org.mozilla.firefox &'
# alias spotify='cd ~/ && nohup flatpak run com.spotify.Client --enable-features=UseOzonePlatform --ozone-platform=wayland &'
alias spotify='cd ~/ && nohup spotify-launcher &'
alias qalculate-qt='cd ~/ && nohup flatpak run io.github.Qalculate.qalculate-qt &'
alias qalculate='cd ~/ && nohup flatpak run io.github.Qalculate.qalculate-qt &'
alias gcolor='cd ~/ && nohup flatpak run nl.hjdskes.gcolor3 &'
alias bitwarden='cd ~/ && nohup flatpak run com.bitwarden.desktop &'
alias monero='cd ~/ && nohup flatpak run org.getmonero.Monero &'
alias eclipse='cd ~/ && nohup flatpak run org.eclipse.Java &'
alias stremio='cd ~/ && nohup flatpak run com.stremio.Stremio &'
alias brave='cd ~/ && QT_QPA_PLATFORMTHEME=qt5ct:qt6ct nohup /usr/bin/brave &'
alias bravebrowser='cd ~/ && QT_QPA_PLATFORMTHEME=qt5ct:qt6ct nohup /usr/bin/brave &'
alias thunderbird='cd ~/ && nohup flatpak run org.mozilla.Thunderbird &'

alias dosbox-staging='cd ~/ && nohup flatpak run io.github.dosbox-staging &'
alias dosbox='cd ~/ && nohup flatpak run io.github.dosbox-staging &'
alias lime3ds='cd ~/ && nohup flatpak run io.github.lime3ds.Lime3DS &'
alias ryujinx='cd ~/ && DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0 nohup flatpak run org.ryujinx.Ryujinx &'
alias yuzu='cd ~/ && nohup flatpak run org.yuzu_emu.yuzu &'
alias citra='cd ~/ && nohup flatpak run org.citra_emu.citra &'
alias cemu='cd ~/ && nohup flatpak run info.cemu.Cemu &'
alias duckstation='cd ~/ && nohup flatpak run org.duckstation.DuckStation &'
alias retroarch='cd ~/ && nohup flatpak run org.libretro.RetroArch &'
alias n64emu='cd ~/ && nohup flatpak run com.github.Rosalie241.RMG &'
alias project64='cd ~/ && nohup flatpak run com.github.Rosalie241.RMG &'
alias dolphin-emu='cd ~/ && nohup flatpak run org.DolphinEmu.dolphin-emu &'
alias dolphin-emulator='cd ~/ && nohup flatpak run org.DolphinEmu.dolphin-emu &'
alias PCSX2='cd ~/ && nohup flatpak run net.pcsx2.PCSX2 &'
alias ps2emu='cd ~/ && nohup flatpak run net.pcsx2.PCSX2 &'
alias RPCS3='cd ~/ && nohup flatpak run net.rpcs3.RPCS3 &'
alias ps3emu='cd ~/ && nohup flatpak run net.rpcs3.RPCS3 &'

alias heroicgameslauncher='cd ~/ && nohup flatpak run com.heroicgameslauncher.hgl &'
alias heroic='cd ~/ && nohup flatpak run com.heroicgameslauncher.hgl &'
alias gdlauncher='cd ~/ && nohup flatpak run io.gdevs.GDLauncher &'
alias playonlinux='cd ~/ && nohup flatpak run org.phoenicis.playonlinux &'
alias boxes='cd ~/ && nohup flatpak run org.gnome.Boxes &'
alias gnome-boxes='cd ~/ && nohup flatpak run org.gnome.Boxes &'
alias bottles='cd ~/ && nohup flatpak run com.usebottles.bottles &'
alias atoms='cd ~/ %% nohup flatpak run pm.mirko.Atoms &'

# alias dosbox-staging='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.dosbox-staging &'
# alias dosbox='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.dosbox-staging &'
# alias lime3ds='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.lime3ds.Lime3DS &'
# alias ryujinx='cd ~/ && DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0 nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.ryujinx.Ryujinx &'
# alias yuzu='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.yuzu_emu.yuzu &'
# alias citra='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.citra_emu.citra &'
# alias cemu='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run info.cemu.Cemu &'
# alias duckstation='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.duckstation.DuckStation &'
# alias retroarch='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.libretro.RetroArch &'
# alias n64emu='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.github.Rosalie241.RMG &'
# alias project64='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.github.Rosalie241.RMG &'
# alias dolphin-emu='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.DolphinEmu.dolphin-emu &'
# alias dolphin-emulator='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.DolphinEmu.dolphin-emu &'
# alias PCSX2='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.pcsx2.PCSX2 &'
# alias ps2emu='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.pcsx2.PCSX2 &'
# alias RPCS3='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.rpcs3.RPCS3 &'
# alias ps3emu='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.rpcs3.RPCS3 &'
#
# alias heroicgameslauncher='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.heroicgameslauncher.hgl &'
# alias heroic='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.heroicgameslauncher.hgl &'
# alias gdlauncher='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.gdevs.GDLauncher &'
# alias wine='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.winehq.Wine &'
# # alias wine-gecko='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.winehq.Wine.gecko &'
# # alias wine-mono='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.winehq.Wine.mono &'
# alias playonlinux='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.phoenicis.playonlinux &'
# alias boxes='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.gnome.Boxes &'
# alias gnome-boxes='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.gnome.Boxes &'
# alias bottles='cd ~/ && nohup gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.usebottles.bottles &'

# alias ='cd ~/ && nohup flatpak run  &'
