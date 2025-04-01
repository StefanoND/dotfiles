source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

#######################################################
# INITIALIZATION START
#######################################################

set -gx HOMEPATH "$HOME"

# tty command requires that "stdin" is attached to a terminal
# This prevents "stdin" from being redirected from /dev/null
set -gx GPG_TTY (tty)

#######################################################
# INITIALIZATION END
#######################################################

#######################################################
# SOURCING START
#######################################################

# local fish config
if test -f "$HOMEPATH"/.fishrc_local.fish
    source "$HOMEPATH"/.fishrc_local.fish
end

# fish abbreviations
if test -f "$HOMEPATH/.config/fish/abbreviations.fish"
    source "$HOMEPATH/.config/fish/abbreviations.fish"
end

if test -f "$HOMEPATH/.config/fish/abbreviations_local.fish"
    source "$HOMEPATH/.config/fish/abbreviations_local.fish"
end

# Advanced command-not-found hook
if test -f /usr/share/doc/find-the-command/ftc.fish
    source /usr/share/doc/find-the-command/ftc.fish
end

#######################################################
# SOURCING END
#######################################################

#######################################################
# EXPORTS START
#######################################################

# To have colors for ls and all grep commands such as grep, egrep and zgrep
# set -gx CLICOLOR 1
# set -gx LS_COLORS 'no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Color for manpages in less makes manpages a little easier to read
# set -gx LESS_TERMCAP_mb $'\E[01;31m'
# set -gx LESS_TERMCAP_md $'\E[01;31m'
# set -gx LESS_TERMCAP_me $'\E[0m'
# set -gx LESS_TERMCAP_se $'\E[0m'
# set -gx LESS_TERMCAP_so $'\E[01;44;33m'
# set -gx LESS_TERMCAP_ue $'\E[0m'
# set -gx LESS_TERMCAP_us $'\E[01;32m'

# Add timestamp to terminal
# set -gx PROMPT_COMMAND "echo -n \[\$(date +%H:%M:%S)\]\ "

# Default config home
set -gx XDG_CONFIG_HOME "$HOMEPATH/.config"

# Terminal
# set -gx TERM xterm-256color
set -gx TERM kitty

set -gx PIPEWIRE_LATENCY 1024/48000

# Theming
set -gx QT_CURSOR_SIZE 36
set -gx QT_AUTO_SCREEN_SCALE_FACTOR 1
set -gx QT_QPA_PLATFORM wayland:xcb
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx GTK2_RC_FILES "$HOMEPATH/.gtkrc-2.0"
set -gx HYPRCURSOR_THEME catppuccin-mocha-mauve-cursors
set -gx HYPRCURSOR_SIZE 48
set -gx XCURSOR_THEME catppuccin-mocha-mauve-cursors
set -gx XCURSOR_SIZE 36
set -gx GTK_THEME Catppuccin-Dark
# set -gx GDK_BACKEND wayland:x11:* # Don't use, known to break apps
set -gx XDG_MENU_PREFIX arch-

# text editor
set -gx SUDO_EDITOR nvim
set -gx EDITOR nvim
set -gx VISUAL nvim

#browser
set -gx BROWSER brave

# Don't use
# # mail
# set -gx MAIL 'flatpak run org.mozilla.Thunderbird'

# Bat theme
set -gx BAT_THEME "Catppuccin Mocha"

# Use property lists instead of hash-tables for deserialization
set -gx LSP_USE_PLISTS true

# Dotnet
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx DOTNET_ROOT "$HOMEPATH/.dotnet"
set -gx DOTNET_TOOLS "$HOMEPATH/.dotnet/tools"
# set -gx DOTNET_SYSTEM_GLOBALIZATION_INVARIANT 1

# Cargo (Rust package manager)
set -gx CARGO_INSTALL_ROOT "$HOMEPATH/.cargo"
set -gx CARGO_BIN "$CARGO_INSTALL_ROOT/bin"
# set -gx CARGO_BUILD_JOBS $(( $(nproc) + 1 ))

# set -gx MAKEFLAGS "-j$(( $(nproc) + 1 ))"

set -gx LOCAL_BIN "$HOMEPATH/.local/bin"

set -gx NIMBLE_BIN "$HOMEPATH/.nimble/bin"

set -gx NWSCRIPTD_BIN "$HOMEPATH/.local/bin/nwscriptd"
set -gx NWSCRIPTLINT_BIN "$HOMEPATH/.local/bin/nwscript-lint"

set -gx YARN_BIN "$HOMEPATH/.yarn/bin"
set -gx YARN_NODEMODULES_BIN "$HOMEPATH/.config/yarn/global/node_modules/.bin"

set -gx ATUIN_BIN "$HOMEPATH/.atuin/bin"

set -gx NVM_DIR "$HOMEPATH/.config/nvm"
set -gx NVM_DATA "$HOMEPATH/.local/share/nvm"
set -gx NVM_BIN "$HOMEPATH/.local/share/nvm/v23.10.0/bin"

# set -gx LOCALE_ARCHIVE /usr/lib/locale/locale-archive

# set -gx PATH "$PATH:$HOMEPATH/dotfiles/emacs/doom/doomemacs/bin"
# set -gx DOOMDIR "$HOMEPATH/dotfiles/emacs/doom/.doom.d"
# set -gx STEMACSDIR "$HOMEPATH/dotfiles/emacs/stemacs/.stemacs.d"

set -gx EMACS_BIN "$HOMEPATH/.config/emacs/bin"

set -gx fish_user_paths $EMACS_BIN:$NVM_BIN:$ATUIN_BIN:$YARN_NODEMODULES_BIN:$YARN_BIN:$NWSCRIPTD_BIN:$NWSCRIPTLINT_BIN:$NIMBLE_BIN:$DOTNET_TOOLS:$CARGO_BIN:$LOCAL_BIN:$PATH

# NeoVim Snacks plugin
set -gx SNACKS_KITTY true

set -gx STEAM_COMPAT_DATA_DIR $HOMEPATH/.local/share/Steam/steamapps/compatdata
set -gx STEAM_COMPAT_CLIENT_INSTALL_PATH $HOMEPATH/.local/share/Steam

#######################################################
# EXPORTS END
#######################################################

#######################################################
# CONFIGURATIONS START
#######################################################

# Fish Prompt
# set fish_prompt '[\u@\h \W]\$ '

# Consistent and forever fish history
# START
# Number of commands to remember
set -gx history_file "$HOMEPATH/.config/fish/history"
set -gx history_max_entries 100000

# Erase duplicates
# Ignore duplicate lines or lines starting with space
set -gx fish_history_ignore_dups yes

# Set history format
set -gx fish_history_format '%d/%m/%y %H:%M:%S   '
#END

# Replace yay with paru
if not type -q yay; and type -q paru
    abbr --global yay paru
end

# Connects to X server (X11) without authenticating and suppresses all error messages
# Needed for some things to work properly
# Security Risk, see if it's worth for you
# I don't seem to need it for now
# xhost +local:root > /dev/null 2>&1

# Ignore case on auto-completion
set -gx fish_pager_color_completion_normal normal
set -gx fish_pager_color_completion_match --bold --background=brwhite

fish_vi_key_bindings

#######################################################
# CONFIGURATIONS END
#######################################################

#######################################################
# FUNCTIONS START
#######################################################

function ls
    eza -al --color=always --group-directories-first --icons=always --git $argv
end

# Automatically do an ls after each cd
function cd
    if test -z "$argv[1]"
        echo "Please provide a folder"
        return
    end
    z $argv[1] && ls
end

# Neovim
function nvim
    if test -z "$argv[1]"
        echo "Please provide a path/file"
        return
    end
    if test -d $argv[1]
        pushd $argv[1]
    else if test -f $argv[1]
        pushd (dirname $argv[1])
    end
    /usr/local/bin/nvim $argv[1]
end

function sudonvim
    if test -z "$argv[1]"
        echo "Please provide a path/file"
        return
    end
    if test -d $argv[1]
        pushd $argv[1]
    else if test -f $argv[1]
        pushd (dirname $argv[1])
    end
    sudo /usr/local/bin/nvim $argv[1]
end

function sudenvim
    if test -z "$argv[1]"
        echo "Please provide a path/file"
        return
    end
    if test -d $argv[1]
        pushd $argv[1]
    else if test -f $argv[1]
        pushd (dirname $argv[1])
    end
    sudo -E /usr/local/bin/nvim $argv[1]
end

# Extract
function extract
    if test -z "$argv"
        echo "Please provide a file"
        return
    end
    for archive in $argv
        if test -f $archive
            set filename (string replace -r '\.[^.]*$' '' $archive)
            switch $archive
                case *.tar.xz
                    tar xvJf $archive -C ./$filename
                case *.tar.bz2
                    tar xvjf $archive -C ./$filename
                case *.tar.gz
                    tar xvzf $archive -C ./$filename
                case *.tar
                    tar xvf $archive -C ./$filename
                case *.tbz2
                    tar xvjf $archive -C ./$filename
                case *.tgz
                    tar xvzf $archive -C ./$filename
                case *.bz2
                    bzip2 -dc $archive >./$filename
                case *.rar
                    unrar x $archive ./$filename
                case *.gz
                    mkdir ./$filename
                    gunzip -dc $archive >./$filename/$filename
                case *.zip
                    unzip $archive -d ./$filename
                case *.vsix
                    unzip $archive -d ./$filename
                case *.Z
                    mkdir ./$filename
                    uncompress -c $archive >./$filename/$filename
                case *.7z
                    7z x $archive
                case '*'
                    echo "Don't know how to extract '$archive'..."
            end
        else
            echo "'$archive' is not a valid file!"
        end
    end
    sync
end

function ex
    if test -z "$argv"
        echo "Please provide a file"
        return
    end
    extract $argv
end

# Searches for text in all files in the current folder
# -i case-insensitive
# -I ignore binary files
# -H causes filename to be printed
# -r recursive search
# -n causes line number to be printed
# optional: -F treat search term as a literal, not a regular expression
# optional: -l only print filenames and not the matching lines ex. grep -irl $argv[1] *
function ftext
    if test -z "$argv[1]"
        echo "Please provide a search term"
        return
    end
    grep -iIHrn --color=always $argv[1] . | less -r
end

# Copy files or directories/folders with a progress bar
# -a Copies recurse into directories, copies symlinks as symlinks, preserves permissions,
#    preserves modification times, preserves group and owner, preserves special files
#
# -v Verbose
# -u Overwrite if newer
#
# --progress Shows progress during transfer
function cprs
    if test (count $argv) -ne 2
        echo "Please provide two arguments: source and destination"
        return
    end
    if not test -d $argv[1] && not test -f $argv[1]
        echo "Please provide a valid origin file/path"
        return
    end
    if not test -d $argv[2] && not test -f $argv[2]
        echo "Please provide a valid destination file/path"
        return
    end
    if test -f $argv[2]
        echo "A file with the name '$argv[2]' already exists"
        return
    end
    if test -d $argv[2]
        echo "A folder with the name '$argv[2]' already exists"
        return
    end
    rsync -avu --progress $argv[1] $argv[2]
    sync
end

function scprs
    if test (count $argv) -ne 2
        echo "Please provide two arguments: source and destination"
        return
    end
    if not test -d $argv[1] && not test -f $argv[1]
        echo "Please provide a valid origin file/path"
        return
    end
    if not test -d $argv[2] && not test -f $argv[2]
        echo "Please provide a valid destination file/path"
        return
    end
    if test -f $argv[2]
        echo "A file with the name '$argv[2]' already exists"
        return
    end
    if test -d $argv[2]
        echo "A folder with the name '$argv[2]' already exists"
        return
    end
    sudo rsync -avu --progress $argv[1] $argv[2]
    sync
end

# Copy and go to the directory
function cpg
    if test (count $argv) -ne 2
        echo "Please provide two arguments: source and destination"
        return
    end
    if not test -d $argv[1] && not test -f $argv[1]
        echo "Please provide a valid origin file/path"
        return
    end
    if not test -d $argv[2] && not test -f $argv[2]
        echo "Please provide a valid destination file/path"
        return
    end
    if test -f $argv[2]
        echo "A file with the name '$argv[2]' already exists"
        return
    end
    if test -d $argv[2]
        echo "A folder with the name '$argv[2]' already exists"
        return
    end
    cprs $argv[1] $argv[2]
    sync
    cd (dirname $argv[2])
end

# Moves files or directories/folders with a progress bar
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
function mvrs
    if test (count $argv) -ne 2
        echo "Please provide two arguments: source and destination"
        return
    end
    if not test -d $argv[1] && not test -f $argv[1]
        echo "Please provide a valid origin file/path"
        return
    end
    if not test -d $argv[2] && not test -f $argv[2]
        echo "Please provide a valid destination file/path"
        return
    end
    if test -f $argv[2]
        echo "A file with the name '$argv[2]' already exists"
        return
    end
    if test -d $argv[2]
        echo "A folder with the name '$argv[2]' already exists"
        return
    end
    rsync -avu --progress --remove-source-files $argv[1] $argv[2]
    sync
end

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
function smvrs
    if test (count $argv) -ne 2
        echo "Please provide two arguments: source and destination"
        return
    end
    if not test -d $argv[1] && not test -f $argv[1]
        echo "Please provide a valid origin file/path"
        return
    end
    if not test -d $argv[2] && not test -f $argv[2]
        echo "Please provide a valid destination file/path"
        return
    end
    if test -f $argv[2]
        echo "A file with the name '$argv[2]' already exists"
        return
    end
    if test -d $argv[2]
        echo "A folder with the name '$argv[2]' already exists"
        return
    end
    sudo rsync -avu --progress --remove-source-files $argv[1] $argv[2]
    sync
end

# Move and go to the directory
function mvg
    if test (count $argv) -ne 2
        echo "Please provide two arguments: source and destination"
        return
    end
    if not test -d $argv[1] && not test -f $argv[1]
        echo "Please provide a valid origin file/path"
        return
    end
    if not test -d $argv[2] && not test -f $argv[2]
        echo "Please provide a valid destination file/path"
        return
    end
    if test -f $argv[2]
        echo "A file with the name '$argv[2]' already exists"
        return
    end
    if test -d $argv[2]
        echo "A folder with the name '$argv[2]' already exists"
        return
    end
    mvrs $argv[1] $argv[2]
    sync
    cd (dirname $argv[2])
end

# Create and go to the directory
function mkdirg
    mkdir -p $argv[1]
    sync
    cd (dirname $argv[1])
end

# Goes up a specified number of directories  (i.e. up 4)
function up
    if test -z "$argv[1]"
        echo "Please provide the number of directories to go up"
        return
    end
    if test $argv[1] -le 0
        echo "Please provide a positive number"
        return
    end
    set -l d ""
    set -l limit $argv[1]
    for i in (seq 1 $limit)
        set d $d/..
    end
    set d (echo $d | sed 's/^\///')
    if test -z "$d"
        set d ..
    end
    cd $d
end

# GitHub Titus Additions
function gcom
    git add .
    if test -z "$argv[1]"
        git commit -am update
    else
        git commit -am $argv[1]
    end
end

# Add, commit and push
function glazy
    git add .
    if test -z "$argv[1]"
        git commit -am update
    else
        git commit -am $argv[1]
    end
    git push
end

# Saving 3 characters so we don't have to type the extra "it "
function gpush
    git push $argv
end

# Saving 3 characters so we don't have to type the extra "it "
function gpull
    git pull $argv
end

# Encrypt symmetric
function encrypt_sym
    set -l encryptfile $argv[1]
    if test -d $encryptfile
        tar -cf $argv[1].tar.gz $argv[1]
        sync
        set encryptfile $argv[1].tar.gz
    end
    gpg -c --no-symkey-cache --cipher-algo AES256 $encryptfile
    sync
end

# Encrypt asymmetric
function encrypt_asym
    set -l encryptfile $argv[1]
    if test -d $encryptfile
        tar -cf $argv[1].tar.gz $argv[1]
        sync
        set encryptfile $argv[1].tar.gz
    end
    gpg --no-symkey-cache --cipher-algo AES256 $encryptfile
    sync
end

# Unencrypt
function unencrypt
    gpg $argv[1] && sync
end

# Send notification
function notify
    notify-send $argv[1]
end

# Kill app and send notification
function killandnotify
    killall -9 $argv[1]
    notify-send "Killed $argv[1]"
end

# Converts .ico to .png
function icontopng
    echo 'Icon path -> Desired Png name/path -> Width -> Height'
    convert $argv[1] -thumbnail $argv[3]x$argv[4] -alpha on -background none -flatten $argv[2]
    sync
end

# clang-format all in folder
function clang-format-all
    find $argv[1] -iname $argv[2] | xargs clang-format -i
end

function extract
    if test -z "$argv"
        echo "Please provide a file"
        return
    end
    for archive in $argv
        if test -f $archive
            switch $archive
                case *.tar.xz
                    tar xvJf $archive -C ./$filename
                case *.tar.bz2
                    tar xvjf $archive -C ./$filename
                case *.tar.gz
                    tar xvzf $archive -C ./$filename
                case *.tar
                    tar xvf $archive -C ./$filename
                case *.tbz2
                    tar xvjf $archive -C ./$filename
                case *.tgz
                    tar xvzf $archive -C ./$filename
                case *.bz2
                    bzip2 -dc $archive >./$filename
                case *.rar
                    unrar x $archive ./$filename
                case *.gz
                    mkdir ./$filename
                    gunzip -dc $archive >./$filename/$filename
                case *.zip
                    unzip $archive -d ./$filename
                case *.vsix
                    unzip $archive -d ./$filename
                case *.Z
                    mkdir ./$filename
                    uncompress -c $archive >./$filename/$filename
                case *.7z
                    7z x $archive
                case '*'
                    echo "don't know how to extract '$archive'..."
            end
        else
            echo "'$archive' is not a valid file!"
        end
    end
    sync
end

function compile
    if test -z "$argv[1]"
        echo "Please provide a file"
        return
    end
    # if not test -z "$argv[2]"
    #     echo "Please provide a file"
    #     return
    # end

    set -l file $argv[1]

    set -l filename (string replace -r '\.[^.]*$' '' $file)
    set -l fileExtension (string split -r '.' $file)[2..-1]

    switch $fileExtension
        case cpp
            set -l params "-std=c++20 -O2 -ferror-limit=0 -Wall -Wextra -Wpedantic -Wshadow-all -Wno-unused-parameter"
            clang++ $params -o $filename $filename.$fileExtension
            # case cpp
            # clang++ -std=c++20 -Wall -O2 -o $filename $filename.$fileExtension
        case '*'
            printf "Language not supported.\n"
    end
    sync
end

function compiledebug
    if test -z "$argv[1]"
        echo "Please provide a file"
        return
    end
    # if not test -z "$argv[2]"
    #     echo "Please provide a file"
    #     return
    # end

    set -l file "$argv[1]"

    set -l filename (string replace -r '\.[^.]*$' '' $file)
    set -l fileExtension (string split -r '.' $file)[2..-1]

    switch $fileExtension
        case cpp
            set -l params "-std=c++20 -ferror-limit=0 -Wall -Wextra -Wpedantic -Wshadow-all -Wno-unused-parameter --debug"
            clang++ $params -o $filename $filename.$fileExtension
            # case cpp
            # clang++ -std=c++20 -Wall --debug -o $filename $filename.$fileExtension
        case '*'
            printf "Language not supported.\n"
    end
    sync
end

function prefixWine
    flatpak run --env=WINEPREFIX=$argv[1] org.winehq.Wine
end

function prefixWinetricks
    flatpak run --env=WINEPREFIX=$argv[1] --command=winetricks org.winehq.Wine $argv[2..-1]
end

function prefixWinetricksF
    flatpak run --env=WINEPREFIX=$argv[1] --command=winetricks org.winehq.Wine $argv[2..-1] -f
end

function prefixWinetricksQF
    flatpak run --env=WINEPREFIX=$argv[1] --command=winetricks org.winehq.Wine $argv[2..-1] -qf
end

function prefixWinecfg
    flatpak run --env=WINEPREFIX=$argv[1] --command=winecfg org.winehq.Wine $argv[2..-1]
end

function prefixWineboot
    flatpak run --env=WINEPREFIX=$argv[1] --command=wineboot org.winehq.Wine $argv[2..-1]
end

function btrfs-scrub
    sudo btrfs scrub start $argv[1] && sync
end

function btrfs-balance
    sudo btrfs balance start -musage=50 -dusage=50 $argv[1] && sync
end

function makeqrcode
    qrencode -t ansiutf8 <$argv[1]
end

function qrcode
    makeqrcode $argv[1]
end

# Expand ue4cli
function ue
    set -l ue4cli "$HOMEPATH/.local/bin/ue4"
    set -l engine_path ($ue4cli root)

    # cd to ue location
    if test $argv[1] = engine
        cd $engine_path
        # combine clean and build in one command
    else if test $argv[1] = rebuild
        $ue4cli clean
        $ue4cli build
        if test $argv[2] = run
            $ue4cli run
        end
        # build and optionally run while respecting build flags
    else if test $argv[1] = build
        if test $argv[-1] = run
            set -l length (math (count $argv) - 2) # Get length without last param because of 'run'
            $ue4cli build $argv[2..$length]
            $ue4cli run
        else
            $ue4cli build $argv[2..-1]
        end
        # Run project files generation, create a symlink for the compile database and fix-up the compile database
    else if test $argv[1] = gen
        $ue4cli gen
        set -l project (basename (pwd))
        cat ".vscode/compileCommands_$project.json" | python -c 'import json,sys
j = json.load(sys.stdin)
for o in j:
  file = o["file"]
  arg = o["arguments"][1]
  o["arguments"] = ["clang++ -std=c++20 -ferror-limit=0 -Wall -Wextra -Wpedantic -Wshadow-all -Wno-unused-parameter " + file + " " + arg]
print(json.dumps(j, indent=2))' >compile_commands.json
        # Pass through all other commands to ue4
    else
        $ue4cli $argv
    end
end

function updateNeovim
    if not git -C "$HOMEPATH"/.apps/neovim status -uno | grep -iq "Your branch is up to date with"
        git -C "$HOMEPATH"/.apps/neovim pull && sync
        make -C "$HOMEPATH"/.apps/neovim distclean && sync
        # make -C "$HOMEPATH"/.apps/neovim CMAKE_BUILD_TYPE=RelWithDebInfo && sync
        make -C "$HOMEPATH"/.apps/neovim CMAKE_BUILD_TYPE=Release && sync
        sudo make -C "$HOMEPATH"/.apps/neovim install && sync
        echo
        echo Updated
        echo
        exit 0
    end
    echo "Up to date."
end

function timeGit
    time git --no-optional-locks status --porcelain=v1 --ignored=matching -u
end

function premakeLinux
    if not test -f (pwd)/premake5.lua
        cp "$HOMEPATH"/dotfiles/premake5.lua (pwd)/ && sync
    end
    premake5 gmake && sync
    bear -- make && sync
end

function premakeRemove
    rm -rf (pwd)/bin
    rm -rf (pwd)/obj
    rm -f (pwd)/compile_commands.json
    rm -f (pwd)/*.make
    rm -f (pwd)/Makefile
    sync
end

function proton
    "$STEAM_COMPAT_CLIENT_INSTALL_PATH/steamapps/common/Proton - Experimental/proton" $argv
end

# To get appid run the command below, you must have run it at least once for it to be detected
# protontricks -l

# This is bugggy, don't use it.
# function GAME
#     set -l STEAM_COMPAT_DATA_PATH "$STEAM_COMPAT_DATA_DIR"/{APPID}
#     set -l STEAM_COMPAT_CLIENT_INSTALL_PATH "$STEAM_COMPAT_CLIENT_INSTALL_PATH"
#     proton run
#     "$HOMEPATH/.local/share/Steam/steamapps/common/GAME/GAME.exe"
# end

function nwmain
    set -l folder "$STEAM_COMPAT_CLIENT_INSTALL_PATH/steamapps/common/Neverwinter Nights/bin/win32/nwmain.exe"
    set -l params --appid 704450 $folder
    set -l command protontricks-launch $params $args
    set -l excludedArgs -F
    set -l args
    for arg in $argv
        switch $arg
            case $excludedArgs
            case *
                set args $args $arg
        end
    end
    if not test -z "$argv" && test $argv = -F
        $command
    else
        $command &>/dev/null & disown
    end
end

function nwtoolset
    set -l params --appid 704450 "$STEAM_COMPAT_CLIENT_INSTALL_PATH/steamapps/common/Neverwinter Nights/bin/win32/nwtoolset.exe"
    set -l command protontricks-launch $params $args
    set -l excludedArgs -F
    set -l args
    for arg in $argv
        switch $arg
            case $excludedArgs
            case *
                set args $args $arg
        end
    end
    if not test -z "$argv" && test $argv = -F
        $command
    else
        $command &>/dev/null & disown
    end
end

function nwdebugger
    set -l params --appid 704450 "$STEAM_COMPAT_CLIENT_INSTALL_PATH/steamapps/common/Neverwinter Nights/bin/win32/utils/DebugServer.exe"
    set -l command protontricks-launch $params $args
    set -l excludedArgs -F
    set -l args
    for arg in $argv
        switch $arg
            case $excludedArgs
            case *
                set args $args $arg
        end
    end
    if not test -z "$argv" && test $argv = -F
        $command
    else
        $command &>/dev/null & disown
    end
end

function nwhak
    set -l params --appid 704450 "$STEAM_COMPAT_CLIENT_INSTALL_PATH/steamapps/common/Neverwinter Nights/bin/win32/nwhak.exe"
    set -l command protontricks-launch $params $args
    set -l excludedArgs -F
    set -l args
    for arg in $argv
        switch $arg
            case $excludedArgs
            case *
                set args $args $arg
        end
    end
    if not test -z "$argv" && test $argv = -F
        $command
    else
        $command &>/dev/null & disown
    end
end

#######################################################
# FUNCTIONS END
#######################################################

#######################################################
# FZF START
#######################################################

# FZF theme (Catppuccin Mocha)
set -gx FZF_DEFAULT_OPTS " \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Change default FZF command
# --hiden Show hidden files
# --strip-cwd-prefix Strip current working directory
# --exclude .git directories
set -gx fzf_fd_opts --hidden --strip-cwd-prefix --exclude .git

# Preview file with bat
set -gx fzf_preview_file_cmd "bat -n --color=always --line-range :500"

# Preview dir with eza
set -gx fzf_preview_dir_cmd "eza -al --color=always --group-directories-first --icons=always --git"

#######################################################
# FZF END
#######################################################

#######################################################
# EVAL START
#######################################################

# Starship prompt
starship init fish | source

# TheFuck aliases
thefuck --alias | source
thefuck --alias fk | source
thefuck --alias fuck | source

# Zoxide (better cd)
zoxide init fish | source

# Atuin, "Magical"
atuin init fish | source

#######################################################
# EVAL END
#######################################################

# "Fetch system information and display it prettily"
# fastfetch
