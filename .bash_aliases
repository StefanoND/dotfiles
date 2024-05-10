#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Sudo preserving user's envvars
alias sude='sudo -E'
alias firefox='cd ~/ && nohup firefox -P &'
alias heroic='cd ~/ && nohup heroic &'
alias discord='cd ~/ && nohup discord &'
alias steam='cd ~/ && nohup steam &'
alias lutris='cd ~/ && nohup lutris &'
alias thunar='cd ~/ && nohup thunar &'
alias obsidian='cd ~/ && nohup obsidian &'
alias bitwarden='cd ~/ && nohup bitwarden-desktop &'
alias virt-manager='cd ~/ && nohup virt-manager &'
alias virtualbox='cd ~/ && nohup virtualbox &'
alias libreoffice='cd ~/ && nohup libreoffice &'
alias office='cd ~/ && nohup libreoffice &'
alias bottles='cd ~/ && nohup bottles &'
# alias emacsd='/usr/bin/emacs --daemon'
# alias emacs='cd ~/ && nohup emacsclient -c -a emacs &'
alias doomemacsd='/usr/bin/emacs --init-directory="~/dotfiles/emacs/doom/doomemacs" --bg-daemon="doom"'
alias doomemacs='cd ~/ && nohup emacsclient -c -s doom -a doom &'
alias stemacsd='/usr/bin/emacs --init-directory="~/dotfiles/emacs/stemacs/stemacs" --bg-daemon="stemacs"'
alias stemacs='cd ~/ && nohup emacsclient -c -s stemacs -a stemacs &'
alias whatsapp='cd ~/ && nohup whatsapp-for-linux &'
alias eclipse='cd ~/ && nohup eclipse &'
alias qalculate='cd ~/ && nohup qalculate-gtk &'
alias godot='cd ~/ && nohup godot &'
alias blender='cd ~/ && nohup blender &'
alias sudenvim='sudo -E nvim'
alias zoom='cd ~/ && nohup zoom &'
alias torbrowser='cd ~/ && nohup torbrowser-launcher &'
alias syncthing='cd ~/ && nohup syncthing &'
alias yata='cd ~/ && nohup gtk-launch yata &'
alias gdlauncher='cd ~/ && nohup gdlauncher &'
alias codium='cd ~/ && nohup codium --password-store="kwallet5" &'
alias trash='gio trash'
alias rmt='gio trash'

# Neverwinter Nights: Enhanced Edition
alias tlkedit='cd ~/ && nohup gtk-launch tlkedit &'
alias nwnexplorer='cd ~/ && nohup gtk-launch nwnexplorer &'
alias scriptgenerator='cd ~/ && nohup gtk-launch scriptgenerator &'
alias 2dacombinulator='cd ~/ && nohup gtk-launch 2dacombinulator &'
alias nwhak='cd ~/ && nohup gtk-launch nwhak &'
alias nwtoolset='cd ~/ && nohup gtk-launch nwtoolset &'
alias toolset='cd ~/ && nohup gtk-launch nwtoolset &'
alias fix2da='cd ~/ && gtk-launch fix2da &'
alias tidy2da='cd ~/ && gtk-launch tidy2da &'
alias nwsyncUpdate='sudo sh /mnt/SSD_1TB_WORK/WoSEE/Tools/nwsync/nwsync-update.sh'
alias uploadNWSync='sh /mnt/SSD_1TB_WORK/WoSEE/Tools/nwsync/uploadNWSync.sh'
alias modStart='cd /mnt/SSD_1TB_WORK/WoSEE/Server && sh /mnt/SSD_1TB_WORK/WoSEE/Server/mod-start_ptr.sh'
alias modStop='cd /mnt/SSD_1TB_WORK/WoSEE/Server && sh /mnt/SSD_1TB_WORK/WoSEE/Server/mod-stop_ptr.sh'
alias modEnable='cd /mnt/SSD_1TB_WORK/WoSEE/Server && sh /mnt/SSD_1TB_WORK/WoSEE/Server/mod-enable_ptr.sh'
alias modDisable='cd /mnt/SSD_1TB_WORK/WoSEE/Server && sh /mnt/SSD_1TB_WORK/WoSEE/Server/mod-disable_ptr.sh'
alias modStatus='cd /mnt/SSD_1TB_WORK/WoSEE/Server && sh /mnt/SSD_1TB_WORK/WoSEE/Server/mod-status_ptr.sh'
alias modSavechars='cd /mnt/SSD_1TB_WORK/WoSEE/Server && sh /mnt/SSD_1TB_WORK/WoSEE/Server/mod-savechars.sh'

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
alias monero='monerod --block-sync-size 10 --db-sync-mode fastest:sync:8750'
