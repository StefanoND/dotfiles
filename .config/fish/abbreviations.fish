#######################################################
# GENERAL ABBREVIATIONS'S
#######################################################
# To temporarily bypass an abbreviation, we precede the command with a \
# EG: the ls command is abbreviated, but to use the normal ls command you would type \ls

abbr -g discard '>/dev/null &'

# Common use
abbr -g grubup "sudo update-grub"
abbr -g fixpacman "sudo rm /var/lib/pacman/db.lck"
abbr -g tarnow 'tar -acf '
abbr -g untar 'tar -zxvf '
abbr -g wget 'wget -c '
abbr -g rmpkg "sudo pacman -Rdd"
abbr -g psmem 'ps auxf | sort -nr -k 4'
abbr -g psmem10 'ps auxf | sort -nr -k 4 | head -10'

abbr -g dir 'dir --color=auto'
abbr -g vdir 'vdir --color=auto'
abbr -g grep 'ugrep --color=auto'
abbr -g fgrep 'ugrep -F --color=auto'
abbr -g egrep 'ugrep -E --color=auto'
abbr -g hw 'hwinfo --short' # Hardware Info
abbr -g big "expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB ()
abbr -g gitpkg 'pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
abbr -g ip 'ip -color'

# Get fastest mirrors
abbr -g mirror "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
abbr -g mirrord "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
abbr -g mirrors "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
abbr -g mirrora "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Help people new to Arch
abbr -g apt 'man pacman'
abbr -g apt-get 'man pacman'
abbr -g please sudo
abbr -g tb 'nc termbin.com 9999'
abbr -g helpme 'cht.sh --shell'
abbr -g pacdiff 'sudo -H DIFFPROG=meld pacdiff'

# Use magick instead of convert
abbr -g convert magick

# Cleanup orphaned packages
abbr -g cleanup 'sudo pacman -Rns $(pacman -Qtdq)'

# Get the error messages from journalctl
abbr -g jctl "journalctl -p 3 -xb"

# Recent installed packages
abbr -g rip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Sudo preserving user's envvars
abbr -g sude 'sudo -E'

# To see if a command is abbreviated, a file, or a built-in command
abbr -g checkcommand "type -t"

# Show open ports
abbr -g openports 'netstat -nape --inet'

# Update system instead of manually typing
# abbr updatesystem 'sudo pacman -Syy && paru -Su --noconfirm --needed --sudoloop && flatpak update -y && sudo mkinitcpio -P'
abbr -g updatesystem 'sudo pacman -Syy && paru -Su --noconfirm --needed --sudoloop && flatpak update -y && sudo update-grub'

# Clear cache
abbr -g clear-cache 'sudo paccache -r && paru -Sccd'

# Count all files (recursively) in the current folder
abbr -g countfiles "for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# Add an "alert" abbreviation for long running commands.  Use like so:
#   sleep 10; alert
abbr -g alert 'notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Search command line history
abbr -g h "history | grep "

# Search running processes
abbr -g p "ps aux | grep "
abbr -g topcpu "/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
abbr -g f "find . | grep "

# Edit these .bash files
# abbr -g ebrc 'edit ~/.bashrc'
# abbr -g ebal 'edit ~/.bash_aliases'

# abbr -g to show the date
abbr -g da 'date "+%d/%m/%Y %A %T %Z"'

# Use zoxide with CD
# abbr -g cd 'z'

# cd into the old directory
abbr -g bd 'cd "$OLDPWD"'

# Change directory abbr -ges
abbr -g home 'cd ~'
abbr -g cd.. 'cd ..'
abbr -g .. 'cd ..'
abbr -g ... 'cd ../..'
abbr -g .... 'cd ../../..'
abbr -g ..... 'cd ../../../..'
abbr -g ...... 'cd ../../../../..'

# Remove a directory and all files
abbr -g rmd '/bin/rm -rv '
abbr -g rmdir '/bin/rm -rv '
abbr -g rmdf '/bin/rm -rfv '
abbr -g rmdirf '/bin/rm -rfv '
abbr -g rmdirforce '/bin/rm -rfv '

# abbr -g's to modified commands
abbr -g cp 'cp -iv'
abbr -g cpf 'cp -fv'
abbr -g mv 'mv -iv'
abbr -g mvf 'mv -fv'
abbr -g mkdir 'mkdir -p'
abbr -g ping 'ping -c 10'
abbr -g less 'less -R'
abbr -g cls clear

# nvim
abbr -g vi nvim
abbr -g vim nvim
abbr -g svi sudonvim
abbr -g svim sudonvim
abbr -g snvim sudonvim
abbr -g sudovi sudonvim
abbr -g sudovim sudonvim
abbr -g sevi sudenvim
abbr -g sevim sudenvim
abbr -g senvim sudenvim
abbr -g sudoevi sudoenvim
abbr -g sudoevim sudoenvim
abbr -g sudevi sudoenvim
abbr -g sudevim sudoenvim
# nvim Godot integration
abbr -g gdnvim "nvim --listen ./godothost"
abbr -g gdvim "nvim --listen ./godothost"
abbr -g godotnvim "nvim --listen ./godothost"
abbr -g godotvim "nvim --listen ./godothost"
abbr -g nvimgodot "nvim --listen ./godothost"
abbr -g vimgodot "nvim --listen ./godothost"
abbr -g nvimgd "nvim --listen ./godothost"
abbr -g vimgd "nvim --listen ./godothost"
# abbr -g sudo 'sudo -v; sudo '

# Replace cat with bat
abbr -g cat 'bat --style header --style snip --style changes --style header'

# Replace ls with eza
# abbr -g ls 'eza -al --color=always --group-directories-first --icons=always --git'      # all files and dris and permissions
abbr -g la 'eza -a --color=always --group-directories-first --icons=always --git' # all files and dirs
abbr -g ll 'eza -l --color=always --group-directories-first --icons=always --git' # long format
abbr -g lt 'eza -aT --color=always --group-directories-first --icons=always --git' # tree listing
abbr -g l. 'eza -ald --color=always --group-directories-first --icons=always --git .*' # show only dotfiles
abbr -g lx 'eza -l -s extension' # sort by extension
abbr -g lk 'eza -l -s size' # sort by size
abbr -g lc 'eza -l -t modified' # sort by change time
abbr -g lr 'eza -lR' # recursive ls
abbr -g lt 'eza -l -s date' # sort by date
abbr -g lff "eza -l --group-directories-first" # directories first
abbr -g ldl "eza -l" # directories last
abbr -g lf "eza -l | egrep -v '^d'" # files only
abbr -g ldir "eza -l | egrep '^d'" # directories only

# SHA1
abbr -g sha1 'openssl sha1'

# abbr -g's for safe and forced reboots
abbr -g rebootsafe 'sudo shutdown -r now'
abbr -g safereboot 'sudo shutdown -r now'
abbr -g rebootforce 'sudo shutdown -r -n now'
abbr -g forcereboot 'sudo shutdown -r -n now'

# abbr -g chmod commands
abbr -g mx 'chmod a+x'
abbr -g 000 'chmod -R 000'
abbr -g 644 'chmod -R 644'
abbr -g 666 'chmod -R 666'
abbr -g 755 'chmod -R 755'
abbr -g 777 'chmod -R 777'

# abbr -g firefox 'firefox -P & disown'
abbr -g firedragon 'firedragon -P & disown'
abbr -g thunar 'thunar & disown'

# QT's apps
abbr -g dolphin '/usr/bin/dolphin & disown'
abbr -g kate '/usr/bin/kate & disown'

abbr -g virt-manager 'virt-manager & disown'
abbr -g virtualbox 'virtualbox & disown'
# abbr -g emacsd '/usr/bin/emacs --daemon'
# abbr -g emacs 'emacsclient -c -a emacs & disown'
abbr -g doomemacsd '/usr/bin/emacs --init-directory="~/dotfiles/emacs/doom/doomemacs" --bg-daemon="doom"'
abbr -g doomemacst 'emacsclient -c -t -s doom -a doom'
abbr -g doomemacs 'emacsclient -c -s doom -a doom & disown'
abbr -g stemacsd '/usr/bin/emacs --init-directory="~/dotfiles/emacs/stemacs/stemacs" --bg-daemon="stemacs"'
abbr -g stemacst 'emacsclient -c -t -s stemacs -a stemacs'
abbr -g stemacs 'emacsclient -c -s stemacs -a stemacs & disown'
abbr -g godot 'nohup godot & disown'
abbr -g zoom 'nohup zoom & disown'
abbr -g syncthing 'nohup syncthing & disown'
abbr -g yata 'nohup gtk-launch yata & disown'
abbr -g codium 'nohup codium & disown'
# abbr -g codium 'nohup codium --password-store="kwallet5" & disown'
abbr -g code 'nohup vscodium & disown'
abbr -g vscode 'nohup vscodium & disown'
abbr -g trash 'gio trash'
abbr -g rmt 'gio trash'
abbr -g headset-charge-indicator 'nohup python3 ~/dotfiles/apps/headset-charge-indicator/headset-charge-indicator.py & disown'
abbr -g headsetchargeindicator 'nohup python3 ~/dotfiles/apps/headset-charge-indicator/headset-charge-indicator.py & disown'

abbr -g waybar 'nohup waybar & disown'
abbr -g restartwaybar 'killall -9 waybar && sleep 1s && waybar & disown'

# Monero
# abbr -g monero 'monerod --block-sync-size 10 --db-sync-mode fastest:sync:8750'

abbr -g ue4 'echo Please use ue instead.'
abbr -g ue5 'echo Please use ue instead.'

# Using other command in .bashrc.local
# abbr -g ue4 'SDL_VIDEODRIVER=x11 ~/.local/bin/ue4'
# abbr -g ue5 'SDL_VIDEODRIVER=x11 ~/.local/bin/ue4'

# Flatpaks
# WINE
# Wine
#& disown'
abbr -g wine 'nohup flatpak run org.winehq.Wine & disown'
# abbr -g wine-gecko 'nohup flatpak run org.winehq.Wine.gecko & disown'
# abbr -g wine-mono 'nohup flatpak run org.winehq.Wine.mono & disown'
abbr -g winetricks 'nohup flatpak run --command=winetricks org.winehq.Wine'
abbr -g winecfg 'nohup flatpak run --command=winecfg org.winehq.Wine'
abbr -g wineboot 'nohup flatpak run --command=wineboot org.winehq.Wine'

# KDE/QT
abbr -g krita 'nohup flatpak run org.kde.krita & disown'
abbr -g kleopatra 'nohup flatpak run org.kde.kleopatra & disown'
abbr -g okteta 'nohup flatpak run org.kde.okteta & disown'

abbr -g flatseal 'nohup flatpak run com.github.tchx84.Flatseal & disown'
abbr -g libreoffice 'nohup flatpak run org.libreoffice.LibreOffice & disown'
abbr -g office 'nohup flatpak run org.libreoffice.LibreOffice & disown'
abbr -g obsidian 'nohup flatpak run md.obsidian.Obsidian & disown'
abbr -g telegram 'nohup flatpak run org.telegram.desktop & disown'
# abbr -g discord 'nohup flatpak run com.discordapp.Discord --enable-features=UseOzonePlatform --ozone-platform=wayland & disown'
abbr -g discord 'nohup flatpak run dev.vencord.Vesktop & disown'
abbr -g vesktop 'nohup flatpak run dev.vencord.Vesktop & disown'
abbr -g whatsapp 'nohup flatpak run com.github.eneshecan.WhatsAppForLinux & disown'
abbr -g qbittorrent 'nohup flatpak run org.qbittorrent.qBittorrent & disown'
abbr -g tenacity 'nohup flatpak run org.tenacityaudio.Tenacity & disown'
# abbr -g obs-studio 'nohup flatpak run com.obsproject.Studio & disown'
# abbr -g obs 'nohup flatpak run com.obsproject.Studio & disown'
abbr -g smplayer 'nohup flatpak run info.smplayer.SMPlayer & disown'
abbr -g mpv 'nohup flatpak run io.mpv.Mpv & disown'
abbr -g gimp 'nohup flatpak run org.gimp.GIMP & disown'
abbr -g inkscape 'nohup flatpak run org.inkscape.Inkscape & disown'
abbr -g blender 'nohup flatpak run org.blender.Blender & disown'
abbr -g handbrake 'nohup flatpak run fr.handbrake.ghb & disown'
abbr -g github-desktop 'nohup flatpak run io.github.shiftey.Desktop & disown'
abbr -g github 'nohup flatpak run io.github.shiftey.Desktop & disown'
abbr -g unityhub 'nohup flatpak run com.unity.UnityHub & disown'
# abbr -g steam 'nohup flatpak run com.valvesoftware.Steam & disown'
abbr -g steam 'nohup steam & disown'
# abbr -g lutris 'nohup flatpak run net.lutris.Lutris & disown'
abbr -g lutris 'nohup lutris & disown'
# abbr -g lutris 'nohup lutris & disown'
abbr -g epicassetmanager 'nohup epic_asset_manager & disown'
abbr -g eam 'nohup epic_asset_manager & disown'
# abbr -g epicassetmanager 'nohup epic_asset_manager & disown'
# abbr -g eam 'nohup epic_asset_manager & disown'
# abbr -g protonup-qt 'nohup flatpak run net.davidotek.pupgui2 & disown'
# abbr -g protonup 'nohup flatpak run net.davidotek.pupgui2 & disown'
abbr -g antimicrox 'nohup flatpak run io.github.antimicrox.antimicrox & disown'
# abbr -g protontricks 'nohup flatpak run com.github.Matoking.protontricks & disown'
# abbr -g torbrowser-launcher 'nohup flatpak run org.torproject.torbrowser-launcher & disown'
# abbr -g torbrowser 'nohup flatpak run org.torproject.torbrowser-launcher & disown'
abbr -g torbrowser-launcher 'nohup /usr/bin/torbrowser-launcher & disown'
abbr -g torbrowser 'nohup /usr/bin/torbrowser-launcher & disown'
abbr -g mullvadbrowser 'nohup flatpak run net.mullvad.MullvadBrowser & disown'
abbr -g firefox 'nohup flatpak run org.mozilla.firefox & disown'
# abbr -g spotify 'nohup flatpak run com.spotify.Client --enable-features=UseOzonePlatform --ozone-platform=wayland & disown'
abbr -g spotify 'spotify-launcher & disown'
abbr -g qalculate-qt 'nohup flatpak run io.github.Qalculate.qalculate-qt & disown'
abbr -g qalculate 'nohup flatpak run io.github.Qalculate.qalculate-qt & disown'
abbr -g gcolor 'nohup flatpak run nl.hjdskes.gcolor3 & disown'
abbr -g bitwarden 'nohup flatpak run com.bitwarden.desktop & disown'
abbr -g monero 'nohup flatpak run org.getmonero.Monero & disown'
abbr -g eclipse 'nohup flatpak run org.eclipse.Java & disown'
abbr -g stremio 'nohup flatpak run com.stremio.Stremio & disown'
abbr -g brave 'nohup /usr/bin/brave --enable-features=UseOzonePlatform --ozone-platform=wayland & disown'
abbr -g bravebrowser 'nohup /usr/bin/brave --enable-features=UseOzonePlatform --ozone-platform=wayland & disown'
# abbr -g brave 'nohup flatpak run com.brave.Browser & disown'
# abbr -g bravebrowser 'nohup flatpak run com.brave.Browser & disown'
abbr -g thunderbird 'nohup flatpak run org.mozilla.Thunderbird & disown'

abbr -g dosbox-staging 'nohup flatpak run io.github.dosbox-staging & disown'
abbr -g dosbox 'nohup flatpak run io.github.dosbox-staging & disown'
abbr -g lime3ds 'nohup flatpak run io.github.lime3ds.Lime3DS & disown'
abbr -g ryujinx 'DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0 flatpak run org.ryujinx.Ryujinx & disown'
abbr -g yuzu 'nohup flatpak run org.yuzu_emu.yuzu & disown'
abbr -g citra 'nohup flatpak run org.citra_emu.citra & disown'
abbr -g cemu 'nohup flatpak run info.cemu.Cemu & disown'
abbr -g duckstation 'nohup flatpak run org.duckstation.DuckStation & disown'
abbr -g retroarch 'nohup flatpak run org.libretro.RetroArch & disown'
abbr -g n64emu 'nohup flatpak run com.github.Rosalie241.RMG & disown'
abbr -g project64 'nohup flatpak run com.github.Rosalie241.RMG & disown'
abbr -g dolphin-emu 'nohup flatpak run org.DolphinEmu.dolphin-emu & disown'
abbr -g dolphin-emulator 'nohup flatpak run org.DolphinEmu.dolphin-emu & disown'
abbr -g PCSX2 'nohup flatpak run net.pcsx2.PCSX2 & disown'
abbr -g ps2emu 'nohup flatpak run net.pcsx2.PCSX2 & disown'
abbr -g RPCS3 'nohup flatpak run net.rpcs3.RPCS3 & disown'
abbr -g ps3emu 'nohup flatpak run net.rpcs3.RPCS3 & disown'

abbr -g heroicgameslauncher 'nohup flatpak run com.heroicgameslauncher.hgl & disown'
abbr -g heroic 'nohup flatpak run com.heroicgameslauncher.hgl & disown'
abbr -g gdlauncher 'nohup flatpak run io.gdevs.GDLauncher & disown'
abbr -g playonlinux 'nohup flatpak run org.phoenicis.playonlinux & disown'
abbr -g boxes 'nohup flatpak run org.gnome.Boxes & disown'
abbr -g gnome-boxes 'nohup flatpak run org.gnome.Boxes & disown'
abbr -g bottles 'nohup flatpak run com.usebottles.bottles & disown'
abbr -g atoms 'nohup flatpak run pm.mirko.Atoms & disown'

abbr -g teams 'nohup flatpak run com.github.IsmaelMartinez.teams_for_linux & disown'

abbr -g spice 'looking-glass-client -C ~/.config/looking-glass/main.ini'
abbr -g triplewide 'xrandr --setmonitor StSurround auto HDMI-A-0,DisplayPort-0,DisplayPort-1'
abbr -g triplenormal 'xrandr --delmonitor StSurround && xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144 --output HDMI-A-0 --mode 1920x1080 --rate 50 --left-of DisplayPort-0 --output DisplayPort-1 --mode 1920x1080 --rate 50 --right-of DisplayPort-0'

# abbr -g dosbox-staging 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.dosbox-staging & disown'
# abbr -g dosbox 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.dosbox-staging & disown'
# abbr -g lime3ds 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.lime3ds.Lime3DS & disown'
# abbr -g ryujinx 'DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0 gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.ryujinx.Ryujinx & disown'
# abbr -g yuzu 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.yuzu_emu.yuzu & disown'
# abbr -g citra 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.citra_emu.citra & disown'
# abbr -g cemu 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run info.cemu.Cemu & disown'
# abbr -g duckstation 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.duckstation.DuckStation & disown'
# abbr -g retroarch 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.libretro.RetroArch & disown'
# abbr -g n64emu 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.github.Rosalie241.RMG & disown'
# abbr -g project64 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.github.Rosalie241.RMG & disown'
# abbr -g dolphin-emu 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.DolphinEmu.dolphin-emu & disown'
# abbr -g dolphin-emulator 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.DolphinEmu.dolphin-emu & disown'
# abbr -g PCSX2 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.pcsx2.PCSX2 & disown'
# abbr -g ps2emu 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.pcsx2.PCSX2 & disown'
# abbr -g RPCS3 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.rpcs3.RPCS3 & disown'
# abbr -g ps3emu 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run net.rpcs3.RPCS3 & disown'
#
# abbr -g heroicgameslauncher 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.heroicgameslauncher.hgl & disown'
# abbr -g heroic 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.heroicgameslauncher.hgl & disown'
# abbr -g gdlauncher 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.gdevs.GDLauncher & disown'
# abbr -g wine 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.winehq.Wine & disown'
# # abbr -g wine-gecko 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.winehq.Wine.gecko & disown'
# # abbr -g wine-mono 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.winehq.Wine.mono & disown'
# abbr -g playonlinux 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.phoenicis.playonlinux & disown'
# abbr -g boxes 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.gnome.Boxes & disown'
# abbr -g gnome-boxes 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.gnome.Boxes & disown'
# abbr -g bottles 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run com.usebottles.bottles & disown'

# abbr -g 'nohup flatpak run  & disown'
