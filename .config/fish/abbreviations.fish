#######################################################
# GENERAL ABBREVIATIONS'S
#######################################################
# To temporarily bypass an abbreviation, we precede the command with a \
# EG: the ls command is abbreviated, but to use the normal ls command you would type \ls

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

# # Edit these .bash files
# abbr -g ebrc 'edit ~/.bashrc'
# abbr -g ebal 'edit ~/.bash_aliases'

# Edit these fish files
abbr -g efrc 'edit ~/.fishrc.fish'
abbr -g efab 'edit ~/.abbreviations.fish'

# abbr -g to show the date
abbr -g da 'date "+%d/%m/%Y %A %T %Z"'

# # Use zoxide with CD
# abbr -g cd 'z'

# # cd into the old directory
# abbr -g bd 'cd "$OLDPWD"'

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
abbr -g gvim gdvim
abbr -g gdnvim gdvim
abbr -g godotnvim gdvim
abbr -g godotvim gdvim
abbr -g nvimgodot gdvim
abbr -g vimgodot gdvim
abbr -g nvimgd gdvim
abbr -g vimgd gdvim

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

# abbr -g firefox 'firefox -P &>/dev/null & disown'
# abbr -g firedragon 'firedragon -P &>/dev/null & disown'
# abbr -g thunar 'thunar &>/dev/null & disown'

# QT's apps
abbr -g dolphin 'dolphin &>/dev/null & disown'
abbr -g kate 'kate &>/dev/null & disown'

abbr -g virt-manager 'virt-manager &>/dev/null & disown'
abbr -g virtualbox 'virtualbox &>/dev/null & disown'
# abbr -g emacsd '/usr/bin/emacs --daemon'
# abbr -g emacs 'emacsclient -c -a emacs &>/dev/null & disown'
# abbr -g doomemacsd '/usr/bin/emacs --init-directory="~/dotfiles/emacs/doom/doomemacs" --bg-daemon="doom"'
# abbr -g doomemacst 'emacsclient -c -t -s doom -a doom'
# abbr -g doomemacs 'emacsclient -c -s doom -a doom &>/dev/null & disown'
# abbr -g stemacsd '/usr/bin/emacs --init-directory="~/dotfiles/emacs/stemacs/stemacs" --bg-daemon="stemacs"'
# abbr -g stemacst 'emacsclient -c -t -s stemacs -a stemacs'
# abbr -g stemacs 'emacsclient -c -s stemacs -a stemacs &>/dev/null & disown'
abbr -g godot 'godot &>/dev/null & disown'
abbr -g zoom 'zoom &>/dev/null & disown'
abbr -g syncthing 'syncthing &>/dev/null & disown'
abbr -g yata 'gtk-launch yata &>/dev/null & disown'
abbr -g codium 'codium &>/dev/null & disown'
# abbr -g codium 'codium --password-store="kwallet5" &>/dev/null & disown'
abbr -g code 'vscodium &>/dev/null & disown'
abbr -g vscode 'vscodium &>/dev/null & disown'
abbr -g trash 'gio trash'
abbr -g rmt 'gio trash'
abbr -g headset-charge-indicator 'python3 ~/dotfiles/apps/headset-charge-indicator/headset-charge-indicator.py &>/dev/null & disown'
abbr -g headsetchargeindicator 'python3 ~/dotfiles/apps/headset-charge-indicator/headset-charge-indicator.py &>/dev/null & disown'

abbr -g waybar 'waybar &>/dev/null & disown'
abbr -g restartwaybar 'killall -9 waybar && sleep 1s && waybar &>/dev/null & disown'

# Monero
# abbr -g monero 'monerod --block-sync-size 10 --db-sync-mode fastest:sync:8750'

abbr -g ue4 'echo Please use ue instead.'
abbr -g ue5 'echo Please use ue instead.'

# Using other command in .bashrc.local
# abbr -g ue4 'SDL_VIDEODRIVER=x11 ~/.local/bin/ue4'
# abbr -g ue5 'SDL_VIDEODRIVER=x11 ~/.local/bin/ue4'

abbr -g steam 'steam &>/dev/null & disown'
abbr -g lutris 'lutris &>/dev/null & disown'
abbr -g epicassetmanager 'epic_asset_manager &>/dev/null & disown'
abbr -g eam 'epic_asset_manager &>/dev/null & disown'
abbr -g torbrowser-launcher 'torbrowser-launcher &>/dev/null & disown'
abbr -g torbrowser 'torbrowser-launcher &>/dev/null & disown'
abbr -g spotify 'spotify-launcher &>/dev/null & disown'
abbr -g brave 'brave --enable-features=UseOzonePlatform --ozone-platform=wayland &>/dev/null & disown'
abbr -g bravebrowser 'brave --enable-features=UseOzonePlatform --ozone-platform=wayland &>/dev/null & disown'

abbr -g obsidian 'obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland &>/dev/null & disown'
abbr -g spice 'looking-glass-client -C ~/.config/looking-glass/main.ini'
abbr -g triplewide 'xrandr --setmonitor StSurround auto HDMI-A-0,DisplayPort-0,DisplayPort-1'
abbr -g triplenormal 'xrandr --delmonitor StSurround && xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144 --output HDMI-A-0 --mode 1920x1080 --rate 50 --left-of DisplayPort-0 --output DisplayPort-1 --mode 1920x1080 --rate 50 --right-of DisplayPort-0'

abbr -g blender 'blender &>/dev/null & disown'
abbr -g gimp 'gimp &>/dev/null & disown'

# Flatpaks
# WINE
# abbr -g winetricks '--command=winetricks org.winehq.Wine'
# abbr -g winecfg '--command=winecfg org.winehq.Wine'
# abbr -g wineboot '--command=wineboot org.winehq.Wine'

# abbr -g ryujinx 'DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0 flatpak run org.ryujinx.Ryujinx &>/dev/null & disown'
# abbr -g ryujinx 'DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0 gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run org.ryujinx.Ryujinx &>/dev/null & disown'
# abbr -g dosbox 'gamemoderun gamescope -R --prefer-vk-device -W 1920 -H 1080 -r 144 -- flatpak run io.github.dosbox-staging &>/dev/null & disown'
