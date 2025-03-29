#
# ~/.bashrc
#

#######################################################
# INITIALIZATION START
#######################################################

HOMEPATH="$HOME"

# tty command requires that "stdin" is attached to a terminal
# This prevents "stdin" from being redirected from /dev/null
export GPG_TTY=$(tty)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# To load ble.sh by default in interactive sessions reliably
# Documentation available at: https://github.com/akinomyoga/ble.sh/wiki
# And replaces ctrl-S with ctrl-R for history navigation to avoid problems with FZF git
if [ -f "$HOMEPATH"/.local/share/blesh/ble.sh ]; then
  source "$HOMEPATH"/.local/share/blesh/ble.sh --noattach && stty -ixon
fi

DEBUGBASH=n

if [[ ${DEBUGBASH,,} = "y" ]]; then
  BASHPROFILELOG="$HOMEPATH"/bashstart.$$.log
  echo "$BASHPROFILELOG"
  PS4='+ $(date "+%s.%N")\011 '
  exec 3>&2 2>"$BASHPROFILELOG"
  set -x
fi

# curl -L -o cpptools-linux-x64.vsix https://github.com/name/repot/releases/latest/download/file.ext
# curl -L -o cpptools-linux-x64.vsix https://github.com/microsoft/vscode-cpptools/releases/latest/download/cpptools-linux-x64.vsix
# curl -L -o nwscript-ee-language-server.vsix https://github.com/PhilippeChab/nwscript-ee-language-server/releases/download/v2.1.1/nwscript-ee-language-server-2.1.1.vsix

#######################################################
# INITIALIZATION END
#######################################################

#######################################################
# SOURCING START
#######################################################

# if [ -f "$HOMEPATH/.local/share/blesh/lib/vim-surround.sh" ]; then
#   if ! [ -x "$HOMEPATH/.local/share/blesh/lib/vim-surround.sh" ]; then
#     chmod +x "$HOMEPATH/.local/share/blesh/lib/vim-surround.sh"
#   fi
#   source "$HOMEPATH/.local/share/blesh/lib/vim-surround.sh"
# fi

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
  source /etc/bash.bashrc
fi

if [ -f "$HOMEPATH"/.bash_aliases ]; then
  source "$HOMEPATH"/.bash_aliases
fi

if [ -f "$HOMEPATH"/.bash_aliases.local ]; then
  source "$HOMEPATH"/.bash_aliases.local
fi

if [ -f "$HOMEPATH"/.bashrc.local ]; then
  source "$HOMEPATH"/.bashrc.local
fi

# Advanced command-not-found hook
if [ -f /usr/share/doc/find-the-command/ftc.bash ]; then
  source /usr/share/doc/find-the-command/ftc.bash
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# Enable bash completion for clang
if [ -f /usr/share/clang/bash-autocomplete.sh ]; then
  source /usr/share/clang/bash-autocomplete.sh
fi

# FZF for git
# Keybindings https://github.com/junegunn/fzf-git.sh?tab=readme-ov-file#usage
if [ -f "$HOMEPATH"/dotfiles/scripts/fzf-git.sh/fzf-git.sh ]; then
  if ! [ -x "$HOMEPATH"/dotfiles/scripts/fzf-git.sh/fzf-git.sh ]; then
    chmod +x "$HOMEPATH"/dotfiles/scripts/fzf-git.sh/fzf-git.sh
  fi
  source "$HOMEPATH"/dotfiles/scripts/fzf-git.sh/fzf-git.sh
fi

#######################################################
# SOURCING END
#######################################################

#######################################################
# EXPORTS START
#######################################################

# To have colors for ls and all grep commands such as grep, egrep and zgrep
# export CLICOLOR=1
# export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Color for manpages in less makes manpages a little easier to read
# export LESS_TERMCAP_mb=$'\E[01;31m'
# export LESS_TERMCAP_md=$'\E[01;31m'
# export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[01;44;33m'
# export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_us=$'\E[01;32m'

# Add timestamp to terminal
# export PROMPT_COMMAND="echo -n \[\$(date +%H:%M:%S)\]\ "

# Default config home
export XDG_CONFIG_HOME=$HOMEPATH/.config

# Terminal
export TERM=xterm-256color

export PIPEWIRE_LATENCY="1024/48000"

# Theming
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
# export GDK_BACKEND=wayland:x11:* # Don't use, known to break apps
export XDG_MENU_PREFIX=arch-

# text editor
export SUDO_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

#browser
export BROWSER=brave

#terminal
export TERM=kitty

# Don't use
# # mail
# export MAIL='flatpak run org.mozilla.Thunderbird'

# Bat theme
export BAT_THEME='Catppuccin Mocha'

# Use property lists instead of hash-tables for deserialization
export LSP_USE_PLISTS=true

# Dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT=$HOMEPATH/.dotnet
export DOTNET_TOOLS=$HOMEPATH/.dotnet/tools
# export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Cargo (Rust package manager)
export CARGO_INSTALL_ROOT=$HOMEPATH/.cargo
export CARGO_BIN=$CARGO_INSTALL_ROOT/bin
# export CARGO_BUILD_JOBS=$(( $(nproc) + 1 ))

# export MAKEFLAGS="-j$(( $(nproc) + 1 ))"

export LOCAL_BIN=$HOMEPATH/.local/bin

export NIMBLE_BIN=$HOMEPATH/.nimble/bin

export NWSCRIPTD_BIN=$HOMEPATH/.local/bin/nwscriptd
export NWSCRIPTLINT_BIN=$HOMEPATH/.local/bin/nwscript-lint

export YARN_BIN="$HOMEPATH/.yarn/bin"
export YARN_NODEMODULES_BIN="$HOMEPATH/.config/yarn/global/node_modules/.bin"

export ATUIN_BIN="$HOMEPATH/.atuin/bin"

export NVM_DIR="$HOMEPATH/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export BLESHPATH="$HOMEPATH/.local/share/blesh"

export PATH="$ATUIN_BIN:$YARN_NODEMODULES_BIN:$YARN_BIN:$NWSCRIPTD_BIN:$NWSCRIPTLINT_BIN:$NIMBLE_BIN:$DOTNET_TOOLS:$CARGO_BIN:$LOCAL_BIN:$PATH"

# export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# export PATH="$PATH:$HOMEPATH/dotfiles/emacs/doom/doomemacs/bin"
# export DOOMDIR="$HOMEPATH/dotfiles/emacs/doom/.doom.d"
# export STEMACSDIR="$HOMEPATH/dotfiles/emacs/stemacs/.stemacs.d"

# NeoVim Snacks plugin
export SNACKS_KITTY=true

export STEAM_COMPAT_DATA_DIR="$HOMEPATH/.local/share/Steam/steamapps/compatdata"
export STEAM_COMPAT_CLIENT_INSTALL_DIR="$HOMEPATH/.local/share/Steam"

#######################################################
# EXPORTS END
#######################################################

#######################################################
# BASH OPTIONS START
#######################################################

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Allow to use aliases through script
shopt -s expand_aliases

# Disable bash history
# unset HISTFILE

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

#######################################################
# BASH OPTIONS END
#######################################################

#######################################################
# CONFIGURATIONS START
#######################################################

# Bash Prompt
# PS1='[\u@\h \W]\$ '

# Consistent and forever bash history
# START
# Number of commands to remember
HISTSIZE=100000
# Maximum number of lines to remember
HISTFILESIZE=$((HISTSIZE * 2))

# Erase duplicates
# Ignore duplicate lines or lines starting with space
HISTCONTROL=erasedups:ignoreboth

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
  builtin history "${@}"
}

export HISTTIMEFORMAT="%d/%m/%y %H:%M:%S   "
PROMPT_COMMAND='history 1 >> ${HOME}/.bash_eternal_history'
PROMPT_COMMAND=_bash_history_sync
"$PROMPT_COMMAND"
# END

# Replace yay with paru
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Connects to X server (X11) without authenticating and suppresses all error messages
# Needed for some things to work properly
# Security Risk, see if it's worth for you
# I don't seem to need it for now
# xhost +local:root > /dev/null 2>&1

# Variable required for auto-completion
iatest=$(expr index "$-" i)

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then
  bind "set completion-ignore-case on"
fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then
  bind "set show-all-if-ambiguous On"
fi

# Set vi/vim editing mode
set -o vi

# ESC timeout
stty time 0                 # stty timeout
bind 'set keyseq-timeout 0' # bash timeout

#######################################################
# CONFIGURATIONS END
#######################################################

#######################################################
# FUNCTIONS START
#######################################################

# Neovim
nvim() {
  if [ "$1" = "." ]; then
    /usr/local/bin/nvim "$1"
  elif [ -d "$1" ]; then
    /usr/local/bin/nvim -c "cd $1" "$1"
  elif [ -f "$1" ]; then
    /usr/local/bin/nvim -c "cd $(dirname "$1")" "$1"
  elif ! [ -f "$1" ]; then
    /usr/local/bin/nvim -c "cd $(dirname "$1")" "$1"
  fi
}

# Sudo Neovim
sudonvim() {
  if [ "$1" = "." ]; then
    sudo /usr/local/bin/nvim "$1"
  elif [ -d "$1" ]; then
    sudo /usr/local/bin/nvim -c "cd $1" "$1"
  elif [ -f "$1" ]; then
    sudo /usr/local/bin/nvim -c "cd $(dirname "$1")" "$1"
  elif ! [ -f "$1" ]; then
    /usr/local/bin/nvim -c "cd $(dirname "$1")" "$1"
  fi
}

# Sudo -E Neovim
sudenvim() {
  if [ "$1" = "." ]; then
    sudo -E /usr/local/bin/nvim "$1"
  elif [ -d "$1" ]; then
    sudo -E /usr/local/bin/nvim -c "cd $1" "$1"
  elif [ -f "$1" ]; then
    sudo -E /usr/local/bin/nvim -c "cd $(dirname "$1")" "$1"
  elif ! [ -f "$1" ]; then
    /usr/local/bin/nvim -c "cd $(dirname "$1")" "$1"
  fi
}

# FireNvim
firenvim() {
  /usr/local/bin/nvim --headless "+call firenvim#install(0) | q"
}

# Changed from 'ex' to 'extract', added '.tar.xz', added recursion support
extract() {
  for archive in "${@}"; do
    if [ -f "$archive" ]; then
      local filename = ${archive%.*}
      case $archive in
      *.tar.xz) tar xvJf "$archive" -C ./"$filename" ;;
      *.tar.bz2) tar xvjf "$archive" -C ./"$filename" ;;
      *.tar.gz) tar xvzf "$archive" -C ./"$filename" ;;
      *.tar) tar xvf "$archive" -C ./"$filename" ;;
      *.tbz2) tar xvjf "$archive" -C ./"$filename" ;;
      *.tgz) tar xvzf "$archive" -C ./"$filename" ;;
      *.bz2) bzip2 -dc "$archive" >./"$filename" ;;
      *.rar) unrar x "$archive" ./"$filename"/ ;;
      *.gz)
        mkdir ./"$filename"
        gunzip -dc "$archive" >./"$filename"/"$filename"
        ;;
      *.zip) unzip "$archive" -d ./"$filename" ;;
      *.vsix) unzip "$archive" -d ./"$filename" ;;
      *.Z)
        mkdir ./"$filename"
        uncompress -c "$archive" >./"$filename"/"$filename"
        ;;
      *.7z) 7z x "$archive" ;;
      *) echo "don't know how to extract '$archive'..." ;;
      esac
    else
      echo "'$archive' is not a valid file!"
    fi
  done
  sync
}

# Calls extract
ex() {
  extract "${@}"
}

# Edit with neovim
edit() {
  nvim "${@}"
}

# Edit with neovim as sudo
sedit() {
  sudo -E /usr/local/bin/nvim "${@}"
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
  grep -iIHrn --color=always "${1}" . | less -r
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
    rsync -avu --progress "${1}" "${2}"
  else
    #        rsync -lptDvu --progress "${1}" "${2}"
    rsync -avu --progress "${1}" "${2}"
  fi
  sync
}

# Copy files or directories/folder with a progress bar as sudo
scprs() {
  if [ -d "${1}" ]; then
    sudo rsync -avu --progress "${1}" "${2}"
  else
    sudo rsync -avu --progress "${1}" "${2}"
  fi
  sync
}

ls() {
  eza -al --color=always --group-directories-first --icons=always --git "${@}"
}

# Automatically do an ls after each cd
cd() {
  z "${@}" && ls
}

# Copy and go to the directory
cpg() {
  if [ -d "${2}" ]; then
    cprs "${1}" "${2}" && cd "${2}"
  else
    cprs "${1}" "${2}"
  fi
  sync
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
    # rsync -rlptDvu --progress --remove-source-files "${1}" "${2}"
    rsync -avu --progress --remove-source-files "${1}" "${2}"
    sync
  else
    # rsync -lptDvu --progress --remove-source-files "${1}" "${2}"
    rsync -avu --progress --remove-source-files "${1}" "${2}"
    sync
  fi
  sync
}

smvrs() {
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
    # sudo rsync -rlptDvu --progress --remove-source-files "${1}" "${2}"
    sudo rsync -avu --progress --remove-source-files "${1}" "${2}"
  else
    # sudo rsync -lptDvu --progress --remove-source-files "${1}" "${2}"
    sudo rsync -avu --progress --remove-source-files "${1}" "${2}"
  fi
  sync
}

# Move and go to the directory
mvg() {
  if [ -d "${2}" ]; then
    mvrs "${1}" "${2}" && cd "${2}"
  else
    mvrs "${1}" "${2}"
  fi
}

# Create and go to the directory
mkdirg() {
  mkdir -p "${1}" && sync && cd "${1}"
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

# For some reason, rot13 pops up everywhere
rot13() {
  if [ $# -eq 0 ]; then
    tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
  else
    echo "${@}" | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
  fi
}

# Trim leading and trailing spaces (for scripts)
trim() {
  local var=$*
  var="${var#"${var%%[![:space:]]*}"}" # remove leading whitespace characters
  var="${var%"${var##*[![:space:]]}"}" # remove trailing whitespace characters
  echo -n "$var"
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
  git push
}

# Saving 3 characters so we don't have to type the extra "it "
gpush() {
  git push
}

# Saving 3 characters so we don't have to type the extra "it "
gpull() {
  git pull
}

# Encrypt symmetric
encrypt_sym() {
  encryptfile=$1
  if [[ -d $encryptfile ]]; then
    tar -cf "$1".tar.gz "$1"
    encryptfile=$1.tar.gz
    sync
  fi
  gpg -c --no-symkey-cache --cipher-algo AES256 "$encryptfile"
  sync
}

# Encrypt asymmetric
encrypt_asym() {
  encryptfile=$1
  if [[ -d $encryptfile ]]; then
    tar -cf "$1".tar.gz "$1"
    encryptfile=$1.tar.gz
    sync
  fi
  gpg --no-symkey-cache --cipher-algo AES256 "$encryptfile"
  sync
}

# Unencrypt
unencrypt() {
  gpg "$1"
  sync
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
  sync
}

# clang-format all in folder
clang-format-all() {
  find "$1" -iname "$2" | xargs clang-format -i
}

compile() {
  fileName=$1
  fileExtension="${fileName##*.}"

  case "$fileExtension" in
  cpp) clang++ -std=c++20 -O2 -ferror-limit=0 -Wall -Wextra -Wpedantic -Wshadow-all -Wno-unused-parameter -o "${fileName%.*}" "${fileName%.*}".cpp ;;
  # cpp) clang++ -std=c++20 -Wall -O2 -o "${fileName%.*}" "${fileName%.*}".cpp ;;
  *) printf "Language not supported.\n" ;;
  esac
  sync
}

compileDebug() {
  fileName=$1
  fileExtension="${fileName##*.}"

  case "$fileExtension" in
  cpp) clang++ -std=c++20 -ferror-limit=0 -Wall -Wextra -Wpedantic -Wshadow-all -Wno-unused-parameter --debug -o "${fileName%.*}" "${fileName%.*}".cpp ;;
  # cpp) clang++ -std=c++20 -Wall -O2 -o "${fileName%.*}" "${fileName%.*}".cpp ;;
  *) printf "Language not supported.\n" ;;
  esac
  sync
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

btrfs-scrub() {
  sudo btrfs scrub start "$1" && sync
}

btrfs-balance() {
  sudo btrfs balance start -musage=50 -dusage=50 "$1" && sync
}

makeqrcode() {
  qrencode -t ansiutf8 <"$1"
}

qrcode() {
  makeqrcode "$1"
}

# Expand ue4cli
ue() {
  ue4cli=$HOMEPATH/.local/bin/ue4
  engine_path=$("$ue4cli" root)

  # cd to ue location
  if [[ "$1" == "engine" ]]; then
    cd "$engine_path"
  # combine clean and build in one command
  elif [[ "$1" == "rebuild" ]]; then
    "$ue4cli" clean
    "$ue4cli" build
    if [[ "$2" == "run" ]]; then
      "$ue4cli" run
    fi
  # build and optionally run while respecting build flags
  elif [[ "$1" == "build" ]]; then
    if [[ "${@: -1}" == "run" ]]; then
      length="$(($# - 2))" # Get length without last param because of 'run'
      "$ue4cli" build "${@:2:$length}"
      "$ue4cli" run
    else
      shift 1
      "$ue4cli" build "$@"
    fi
  # Run project files generation, create a symlink for the compile database and fix-up the compile database
  elif [[ "$1" == "gen" ]]; then
    "$ue4cli" gen
    project=${PWD##*/}
    cat ".vscode/compileCommands_${project}.json" | python -c 'import json,sys
j = json.load(sys.stdin)
for o in j:
  file = o["file"]
  arg = o["arguments"][1]
  o["arguments"] = ["clang++ -std=c++20 -ferror-limit=0 -Wall -Wextra -Wpedantic -Wshadow-all -Wno-unused-parameter " + file + " " + arg]
print(json.dumps(j, indent=2))' >compile_commands.json
  # Pass through all other commands to ue4
  else
    "$ue4cli" "$@"
  fi
}

updateNvim() {
  if ! "$(git -C "$HOMEPATH"/dotfiles/apps/neovim status -uno)" | grep "Your branch is up to date with"; then
    git -C "$HOMEPATH"/dotfiles/apps/neovim pull
    sync
    make -C "$HOMEPATH"/dotfiles/apps/neovim distclean
    sync
    # make -C "$HOMEPATH"/dotfiles/apps/neovim CMAKE_BUILD_TYPE=RelWithDebInfo
    make -C "$HOMEPATH"/dotfiles/apps/neovim CMAKE_BUILD_TYPE=Release
    sync
    sudo make -C "$HOMEPATH"/dotfiles/apps/neovim install
    sync
    echo
    echo "Updated"
    echo
    exit 0
  fi
  echo "Up to date."
}

timeGit() {
  time git --no-optional-locks status --porcelain=v1 --ignored=matching -u
}

premakeLinux() {
  if ! [ -f "${PWD:?}"/premake5.lua ]; then
    cp "$HOMEPATH"/dotfiles/premake5.lua "${PWD:?}"/
    sync
  fi
  premake5 gmake
  sync
  bear -- make
  sync
}

premakeRemove() {
  rm -rf "${PWD:?}"/bin
  rm -rf "${PWD:?}"/obj
  rm -f "${PWD:?}"/compile_commands.json
  rm -f "${PWD:?}"/*.make
  rm -f "${PWD:?}"/Makefile
  sync
}

proton() {
  "$STEAM_COMPAT_CLIENT_INSTALL_DIR/steamapps/common/Proton - Experimental/proton" "$@"
}

nwmain() {
  # export STEAM_COMPAT_DATA_PATH="$STEAM_COMPAT_DATA_DIR/704450"
  # export STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_COMPAT_CLIENT_INSTALL_DIR"
  protontricks-launch --appid 704450 "$STEAM_COMPAT_CLIENT_INSTALL_DIR/steamapps/common/Neverwinter Nights/bin/win32/nwmain.exe" "$@"
  # proton run
  # "$HOMEPATH/.local/share/Steam/steamapps/common/Neverwinter Nights/bin/win32/nwmain.exe"
}

nwtoolset() {
  # export STEAM_COMPAT_DATA_PATH="$STEAM_COMPAT_DATA_DIR/704450"
  # export STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_COMPAT_CLIENT_INSTALL_DIR"
  protontricks-launch --appid 704450 "$STEAM_COMPAT_CLIENT_INSTALL_DIR/steamapps/common/Neverwinter Nights/bin/win32/nwtoolset.exe" "$@"
  # proton run
  # "$HOMEPATH/.local/share/Steam/steamapps/common/Neverwinter Nights/bin/win32/nwtoolset.exe"
}

nwdebugger() {
  # export STEAM_COMPAT_DATA_PATH="$STEAM_COMPAT_DATA_DIR/704450"
  # export STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_COMPAT_CLIENT_INSTALL_DIR"
  protontricks-launch --appid 704450 "$STEAM_COMPAT_CLIENT_INSTALL_DIR/steamapps/common/Neverwinter Nights/bin/win32/utils/DebugServer.exe" "$@"
  # proton run
  # "$HOMEPATH/.local/share/Steam/steamapps/common/Neverwinter Nights/bin/win32/utils/DebugServer.exe"
}

nwhak() {
  # export STEAM_COMPAT_DATA_PATH="$STEAM_COMPAT_DATA_DIR/704450"
  # export STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_COMPAT_CLIENT_INSTALL_DIR"
  protontricks-launch --appid 704450 "$STEAM_COMPAT_CLIENT_INSTALL_DIR/steamapps/common/Neverwinter Nights/bin/win32/nwhak.exe" "$@"
  # proton run
  # "$HOMEPATH/.local/share/Steam/steamapps/common/Neverwinter Nights/bin/win32/nwhak.exe"
}

#######################################################
# FUNCTIONS END
#######################################################

#######################################################
# BINDS END
#######################################################

# bind '"discard":">/dev/null 2>&1 &"'

#######################################################
# BINDS END
#######################################################

#######################################################
# FZF START
#######################################################

# Enable FZF (for bash)
eval "$(fzf --bash)"

# FZF theme (Catppuccin Mocha)
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Change default FZF command
# --hiden Show hidden files
# --strip-cwd-prefix Strip current working directory
# --exclude .git directories
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'

# Pressing Ctrl + T after typing something in terminal will run FZF_DEFAULT_COMMAND for files
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Pressing Alt + C after typing something in terminal will run FZF_DEFAULT_COMMAND for directories
# --type=(d)irectory
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type=d"

# For when suffixing "**" to anything then pressing TAB
# Like: "nvim **", "killall -9 **", etc
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# "$1" is the base path to start traversal
_fzf_compgen_path() {
  fd --hidden --exclude ".git" . "$1"
}

# For when typing "cd **" then pressing TAB
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --exclude ".git" . "$1"
}

# Pressing Ctrl + T now uses Bat to preview
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"

# Pressing Ctrl + T now uses eza to ls
export FZF_ALT_C_OPTS="--preview 'eza -al --color=always --group-directories-first --icons=always --git | head -200'"

# Needed for Bat Preview to work
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd) fzf --preview 'eza -T --color=always --group-directories-first --icons=always --git {} | head -200' "${@}" ;;
  export | unset) fzf --preview "eval 'echo $' {}" "${@}" ;;
  ssh) fzf --preview 'dig {}' "${@}" ;;
  *) fzf --preview "bat -n --color=always --line-range :500 {}" "${@}" ;;
  esac
}

#######################################################
# FZF END
#######################################################

#######################################################
# EVAL START
#######################################################

# Load starship prompt if starship is installed
# eval "$(starship init bash)"
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

# Enable auto-completion for pipx
eval "$(register-python-argcomplete pipx)"

# TheFuck aliases
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"
eval "$(thefuck --alias fuck)"

# Enable Zoxide (better cd)
# eval "$(zoxide init bash)"
if [ -x /usr/bin/zoxide ]; then
  __main() {
    local major="${BASH_VERSINFO[0]}"
    local minor="${BASH_VERSINFO[1]}"

    if ((major > 4)) || { ((major == 4)) && ((minor >= 1)); }; then
      source <("/usr/bin/zoxide" init bash)
    else
      source /dev/stdin <<<"$("/usr/bin/zoxide" init bash)"
    fi
  }
  __main
  unset -f __main
fi

# Atuin, "Magical"
eval "$(atuin init bash)"

#######################################################
# EVAL END
#######################################################

# "Fetch system information and display it prettily"
fastfetch

# if [[ ${DEBUGBASH,,} = "y" ]]; then
#   if [[ ${BLE_VERSION-} ]]; then
#     ble/debug/profiler/start a
#     ble-attach
#     ble/debug/profiler/stop
#   fi
# else
#   [[ ! ${BLE_VERSION-} ]] || ble-attach
# fi

# Don't remove the line below
# Documentation available at: https://github.com/akinomyoga/ble.sh/wiki
[[ ! ${BLE_VERSION-} ]] || ble-attach

if [[ ${DEBUGBASH,,} = "y" ]]; then
  set +x
  exec 2>&3 3>&-
fi
