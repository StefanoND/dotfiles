# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Advanced command-not-found hook
source /usr/share/doc/find-the-command/ftc.bash

## Useful aliases

# Replace ls with exa
alias ls='eza -al --color=always --group-directories-first --icons --git'     # preferred listing
alias la='eza -a --color=always --group-directories-first --icons --git'      # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons --git'      # long format
alias lt='eza -aT --color=always --group-directories-first --icons --git'     # tree listing
alias l.='eza -ald --color=always --group-directories-first --icons --git .*' # show only dotfiles

# Replace some more things with better alternatives
alias cat='bat --style header --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias upd='/usr/bin/garuda-update'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='ugrep --color=auto'
alias fgrep='ugrep -F --color=auto'
alias egrep='ugrep -E --color=auto'
alias hw='hwinfo --short'                          # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"     # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias ip='ip -color'

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Help people new to Arch
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'
alias helpme='cht.sh --shell'
alias pacdiff='sudo -H DIFFPROG=meld pacdiff'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
fastfetch -l garuda

#######################################################
# PERSONAL CONFIGS
#######################################################

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Allow to use aliases through script
shopt -s expand_aliases

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend

# Changed from 'ex' to 'extract', added '.tar.xz', added recursion support
extract() {
        for archive in "$@"; do
                if [ -f "$archive" ]; then
                        case $archive in
                        *.tar.xz) tar xvJf "$archive" ;;
                        *.tar.bz2) tar xvjf "$archive" ;;
                        *.tar.gz) tar xvzf "$archive" ;;
                        *.bz2) bunzip2 "$archive" ;;
                        *.rar) unrar x "$archive" ;;
                        *.gz) gunzip "$archive" ;;
                        *.tar) tar xvf "$archive" ;;
                        *.tbz2) tar xvjf "$archive" ;;
                        *.tgz) tar xvzf "$archive" ;;
                        *.zip) unzip "$archive" ;;
                        *.Z) uncompress "$archive" ;;
                        *.7z) 7z x "$archive" ;;
                        *) echo "don't know how to extract '$archive'..." ;;
                        esac
                else
                        echo "'$archive' is not a valid file!"
                fi
        done
}

# Calls extract
ex() {
        extract "$@"
}

iatest=$(expr index "$-" i)

#######################################################
# SOURCED ALIAS'S AND SCRIPTS BY zachbrowne.me
#######################################################

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
        source /etc/bash.bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
fi

if [ -f "$HOME"/.bash_aliases ]; then
        source "$HOME"/.bash_aliases
fi

if [ -f "$HOME"/dotfiles/apps/ble.sh/out/ble.sh ]; then
        source "$HOME"/dotfiles/apps/ble.sh/out/ble.sh
elif [ -f /usr/share/blesh/ble.sh ]; then
        source /usr/share/blesh/ble.sh
fi

#######################################################
# EXPORTS
#######################################################

# Consistent and forever bash history
# START
HISTSIZE=100000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=erasedups:ignorespace:ignoredups

_bash_history_sync() {
        builtin history -a
        HISTFILESIZE=$HISTSIZE
}

_bash_history_sync_and_reload() {
        builtin history -a
        HISTFILESIZE=$HISTSIZE
        builtin history -c
        builtin history -r
}

history() {
        _bash_history_sync_and_reload
        builtin history "$@"
}

export HISTTIMEFORMAT="%d/%m/%y %H:%M:%S   "
PROMPT_COMMAND='history 1 >> ${HOME}/.bash_eternal_history'
PROMPT_COMMAND=_bash_history_sync
"$PROMPT_COMMAND"
# FINISH

# Allow ctrl-S for history navigation (with ctrl-R)
[[ $- == *i* ]] && stty -ixon

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Set the default editor
export SUDO_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################################
# SPECIAL FUNCTIONS
#######################################################

# Use the best version of pico installed
edit() {
        if [ "$(type -t jpico)" = "file" ]; then
                # Use JOE text editor http://joe-editor.sourceforge.net/
                jpico -nonotice -linums -nobackups "$@"
        elif [ "$(type -t nano)" = "file" ]; then
                nano -c "$@"
        elif [ "$(type -t pico)" = "file" ]; then
                pico "$@"
        else
                nvim "$@"
        fi
}
sedit() {
        if [ "$(type -t jpico)" = "file" ]; then
                # Use JOE text editor http://joe-editor.sourceforge.net/
                sudo jpico -nonotice -linums -nobackups "$@"
        elif [ "$(type -t nano)" = "file" ]; then
                sudo nano -c "$@"
        elif [ "$(type -t pico)" = "file" ]; then
                sudo pico "$@"
        else
                sudo nvim "$@"
        fi
}

# Searches for text in all files in the current folder
ftext() {
        # -i case-insensitive
        # -I ignore binary files
        # -H causes filename to be printed
        # -r recursive search
        # -n causes line number to be printed
        # optional: -F treat search term as a literal, not a regular expression
        # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
        grep -iIHrn --color=always "$1" . | less -r
}

# Copy files or directories/folders with a progress bar
cprs() {
        # -a Copies recurse into directories, copies symlinks as symlinks, preserves permissions,
        #    preserves modification times, preserves group and owner, preserves special files
        #
        # -v Verbose
        # -u Overwrite if newer
        #
        # --progress Shows progress during transfer
        if [ -d "${1}" ]; then
                #        rsync -rlptDvu --progress "${1}"/ "${2}"
                rsync -avu --progress "${1}"/ "${2}"
        else
                #        rsync -lptDvu --progress "${1}" "${2}"
                rsync -avu --progress "${1}" "${2}"
        fi
}

# Copy files or directories/folder with a progress bar as sudo
scprs() {
        if [ -d "${1}" ]; then
                sudo rsync -rlptDvu --progress "${1}/" "${2}"
        else
                sudo rsync -lptDvu --progress "${1}" "${2}"
        fi
}

# Copy and go to the directory
cpg() {
        if [ -d "$2" ]; then
                cprs "$1" "$2" && cd "$2"
        else
                cprs "$1" "$2"
        fi
}

# Moves files or directories/folders with a progress bar
mvrs() {
        # Not trully a move since it copies the files to destination then deletes source files
        #
        # -a Copies recurse into directories, copies symlinks as symlinks, preserves permissions,
        #    preserves modification times, preserves group and owner, preserves special files
        #
        # -v Verbose
        # -u Overwrite if newer
        #
        # --progress Shows progress during transfer
        # --remove-source-files deletes files from source
        if [ -d "${1}" ]; then
                sudo rsync -rlptDvu --progress --remove-source-files "${1}/" "${2}"
                rmd "${1}"
        else
                sudo rsync -lptDvu --progress --remove-source-files "${1}" "${2}"
                #rm "${1}"
        fi
}

# Move and go to the directory
mvg() {
        if [ -d "$2" ]; then
                mvv "$1" "$2" && cd "$2"
        else
                mvv "$1" "$2"
        fi
}

# Create and go to the directory
mkdirg() {
        mkdir -p "$1"
        cd "$1"
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
        local d=""
        limit=$1
        for ((i = 1; i <= limit; i++)); do
                d=$d/..
        done
        d=$(echo "$d" | sed 's/^\///')
        if [ "$d" = "" ]; then
                d=..
        fi
        cd "$d"
}

# Automatically do an ls after each cd
cd() {
        z "$@" && ls
}

# For some reason, rot13 pops up everywhere
rot13() {
        if [ $# -eq 0 ]; then
                tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
        else
                echo "$@" | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
        fi
}

# Trim leading and trailing spaces (for scripts)
trim() {
        local var=$*
        var="${var#"${var%%[![:space:]]*}"}" # remove leading whitespace characters
        var="${var%"${var##*[![:space:]]}"}" # remove trailing whitespace characters
        echo -n "$var"
}

econ() {
        expressvpn connect "$1"
}

# Reconnect expressvpn to chosen server
erecon() {
        expressvpn disconnect && sleep 1s && expressvpn connect "$1"
}

edisc() {
        expressvpn disconnect
}

# GitHub Titus Additions
gcom() {
        git add .
        if [ "$1" == "" ]; then
                git commit -am "update"
        else
                git commit -am "$1"
        fi
}

# Add, commit and push
glazy() {
        git add .
        if [ "$1" == "" ]; then
                git commit -am "update"
        else
                git commit -am "$1"
        fi
        git push origin HEAD
}

# Saving 3 characters so we don't have to type the extra "it "
gpush() {
        git push origin HEAD
}

# Saving 3 characters so we don't have to type the extra "it "
gpull() {
        git pull --rebase
}

# Encrypt symmetric
encrypt_sym() {
        encryptfile=$1
        if [[ -d $encryptfile ]]; then
                tar -cf "$1".tar.gz "$1"
                encryptfile=$1.tar.gz
        fi
        gpg -c --no-symkey-cache --cipher-algo AES256 "$encryptfile"
}

# Encrypt asymmetric
encrypt_asym() {
        encryptfile=$1
        if [[ -d $encryptfile ]]; then
                tar -cf "$1".tar.gz "$1"
                encryptfile=$1.tar.gz
        fi
        gpg --no-symkey-cache --cipher-algo AES256 "$encryptfile"
}

# Unencrypt
unencrypt() {
        gpg "$1"
}

# Send notification
notify() {
        notify-send "$1"
}

# Kill app and send notification
killandnotify() {
        killall -9 "$1"
        notify-send "Killed $1"
}

# Converts .ico to .png
icontopng() {
        echo 'Icon path -> Desired Png name/path -> Size'
        convert "$1" -thumbnail "$3"x"$3" -alpha on -background none -flatten "$2"
}

# clang-format all in folder
clang-format-all() {
        find "$1" -iname "$2" | xargs clang-format -i
}

prefixWine() {
        flatpak run --env="WINEPREFIX=$1" org.winehq.Wine
}

prefixWinetricks() {
        flatpak run --env="WINEPREFIX=$1" --command=winetricks org.winehq.Wine "${*:2}"
}

prefixWinetricksF() {
        flatpak run --env="WINEPREFIX=$1" --command=winetricks org.winehq.Wine "${*:2}" -f
}

prefixWinetricksQF() {
        flatpak run --env="WINEPREFIX=$1" --command=winetricks org.winehq.Wine "${*:2}" -qf
}

prefixWinecfg() {
        flatpak run --env="WINEPREFIX=$1" --command=winecfg org.winehq.Wine "${*:2}"
}

prefixWineboot() {
        flatpak run --env="WINEPREFIX=$1" --command=wineboot org.winehq.Wine "${*:2}"
}

# alias lookingglass="~/looking-glass-B5.0.1/client/build/looking-glass-client -F"

#######################################################
# "Ultimate amazing command prompt"
#######################################################

# Install Starship - curl -sS https://starship.rs/install.sh | sh

# Load starship prompt if starship is installed
if [ -x /usr/bin/starship ]; then
        __main() {
                local major="${BASH_VERSINFO[0]}"
                local minor="${BASH_VERSINFO[1]}"

                if ((major > 4)) || { ((major == 4)) && ((minor >= 1)); }; then
                        source <("/usr/bin/starship" init bash --print-full-init)
                else
                        source /dev/stdin <<<"$("/usr/bin/starship" init bash --print-full-init)"
                fi
        }
        __main
        unset -f __main
fi

# Autojump

if [ -f "/usr/share/autojump/autojump.sh" ]; then
        source /usr/share/autojump/autojump.sh
elif [ -f "/usr/share/autojump/autojump.bash" ]; then
        source /usr/share/autojump/autojump.bash
fi

#######################################################
# PERSONAL COMMANDS
#######################################################

# Makes new panels open $HOME instead of folder you're currently in
# wezterm set-working-directory "$HOME"

export CARGO_INSTALL_ROOT=$HOME/.cargo
export PATH="$PATH:$CARGO_INSTALL_ROOT/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/dotfiles/emacs/doom/doomemacs/bin"
export PATH="$PATH:/usr/local"
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# The name is in ~/dotfiles/emacs/.emacs-profiles.el
setdefaultemacsprofile() {
        echo "$1" >~/dotfiles/emacs/.emacs-profile
}

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

export XDG_CONFIG_HOME="$HOME/.config"

export PATH="$HOME/.nimble/bin":$PATH
export NWN_ROOT='/mnt/SSD_1TB_GAMES/SteamLibrary/steamapps/common/Neverwinter Nights'
export NWN_HOME='/mnt/SSD_1TB_WORK/WoSEE/Documents'

eval "$(register-python-argcomplete pipx)"

export GPG_TTY=$(tty)

# Setup fzf keybindings and fuzzy completion
eval "$(fzf --bash)"

# fzf theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Use fd isntead of fzf

export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

# Use fd for listing path candidates.
# "$1" is the base path to start traversal
_fzf_compgen_path() {
        fd --hidden --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
        fd --type d --hidden --exclude ".git" . "$1"
}

source ~/dotfiles/scripts/fzf-git.sh/fzf-git.sh

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza -al --color=always --group-directories-first --icons --git | head -200'"

_fzf_comprun() {
        local command=$1
        shift

        case "$command" in
        cd) fzf --preview 'eza -T --color=always --group-directories-first --icons --git {} | head -200' "$@" ;;
        export | unset) fzf --preview "eval 'echo $' {}" "$@" ;;
        ssh) fzf --preview 'dig {}' "$@" ;;
        *) fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
        esac
}

# Bat theme
export BAT_THEME='Catppuccin Mocha'

# TheFuck alias
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

# Zoxide (better cd)
eval "$(zoxide init bash)"

. "$HOME"/dotfiles/apps/z/z.sh

export LSP_USE_PLISTS=true

DOOMDIR="$HOME/dotfiles/emacs/doom/.doom.d"
STEMACSDIR="$HOME/dotfiles/emacs/stemacs/.stemacs.d"
