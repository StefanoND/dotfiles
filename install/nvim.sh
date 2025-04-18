#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
  echo
  echo "Don't run this script as root"
  echo
  sleep 1s
  exit 1
fi

# For server using debian
#sudo apt install -y clang clangd clang-tools clang-format clang-tidy cmake cmake-extras && sync

export DOTNET_CLI_TELEMETRY_OPTOUT=1

HOMEPATH="$HOME"
APPTSPATH="$HOMEPATH"/.apps
DOTFILESPATH="$HOMEPATH"/dotfiles

if ! [ -d "$HOMEPATH"/.vim/undodir ]; then
  mkdir -p "$HOMEPATH"/.vim/undodir
fi
if ! [ -d "$HOMEPATH"/.cache/ccls ]; then
  mkdir -p "$HOMEPATH"/.cache/ccls
fi
if ! [ -d "$APPTSPATH" ]; then
  mkdir "$HOMEPATH"/.apps
fi

ln -svf "$DOTFILESPATH"/.config/tmux "$HOMEPATH"/.config/
ln -svf "$DOTFILESPATH"/.config/nvim "$HOMEPATH"/.config/

ln -svf "$DOTFILESPATH"/.editorconfig "$HOMEPATH"/
ln -svf "$DOTFILESPATH"/.clang-format "$HOMEPATH"/

sudo pacman -Syy

# PACMAN - Neovim
PKGA=(
  # Neovim
  'base-devel'
  'ninja'
  'curl'
  'ccache'
  'gcc'
  'cmake'               # CMake Software Builder
  'cmake-extras'        # CMake Addons
  'extra-cmake-modules' # Extra Modules and Scripts for CMake
  'llvm'
  'clang' # C family goodie
  'ccls'  # C family goodie
  'automake'
  'libtool'
  'premake'
  'bear'
  'lldb'
  'gdb'
  'ispc'
  'ctags'
  'doxygen'
  'tree-sitter-cli'
  'texlive-bin'
  'texlive-latexrecommended'
  'texlive-latexextra'

  # tmux
  'tmux'
  'wl-clipboard'

  #
  # 'npm'
  'luarocks'
  'rustup'  # Rust programming language software
  'ripgrep' # Better "grep"
  'fd'      # Better "find"
  'shfmt'
  'shellcheck'
  'lazygit'
  'omnisharp-roslyn'
  'lua-language-server'
  'python3'
  'python-pip'
  'python-pipx'
  'python-argcomplete'
  'pyton-pylatexenc'
  'cmake'
  'cmake-extras'
  'imagemagick'

  # C Sharp
  'dotnet-sdk'
  'dotnet-sdk-6.0'
  'dotnet-sdk-7.0'
  'dotnet-sdk-8.0'
  'aspnet-runtime'
  'aspnet-runtime-6.0'
  'aspnet-runtime-7.0'
  'aspnet-runtime-8.0'
  'dotnet-targeting-pack'
  'dotnet-targeting-pack-6.0'
  'dotnet-targeting-pack-7.0'
  'dotnet-targeting-pack-8.0'
  'aspnet-targeting-pack'
  'aspnet-targeting-pack-6.0'
  'aspnet-targeting-pack-7.0'
  'aspnet-targeting-pack-8.0'
  'mono'
  'mono-msbuild'
  'mono-msbuild-sdkresolver'
  'libuv'

  'github-cli'
)

for PKG in "${PKGA[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | sudo pacman -S "$PKG" --needed
  sync
  sleep 1s
done

NVM_VERSION=$(curl -s "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*') &&
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash &&
  export NVM_DIR="$HOMEPATH/.config/nvm" &&
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" &&
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install --latest-npm node && sync

# make CMAKE_BUILD_TYPE=RelWithDebInfo
make -C "$HOMEPATHPATH"/.apps/neovim CMAKE_BUILD_TYPE=Release

sudo make -C "$HOMEPATHPATH"/.apps/neovim install

luarocks config local_by_default true
luarocks install lua-utils

paru -Syy

# PARU
PKGB=(
  # nvim Dependencies
  'shell-color-scripts-git'
)

for PKG in "${PKGB[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  paru -S "$PKG" --noconfirm --needed --sudoloop
  sync
done

# PARU
PKGC=(
  # nvim Dependencies
  'markdown'
  'pynvim'
  'cmake-language-server'
  'ue4cli'
  'gdtoolkit'
  'grip'
  'rollnw'
  'arclight'
  'hererocks'
)

for PKG in "${PKGC[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  CC=cc python -m pip install --user --upgrade --break-system-packages "$PKG"
  sync
done

rustup install stable

rustup target install i686-unknown-linux-gnu

rustup default stable

cargo install async-cmd

cargo install shellharden

npm i -g all-the-package-names

npm i -g npm@latest

# npm i --package-lock-only
# sync

npm audit fix
sleep 1s

# NPM
PKGD=(
  # LSP
  # 'vscode-langservers-extracted'
  'bash-language-server'
  'tailwindcss-language-server'
  'typescript'
  'typescript-language-server'
  'yarn'
  '@vscode/vsce'
  'fish-lsp'
)

for PKG in "${PKGD[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  npm i -g "$PKG"
  sync
  sleep 1s
done

export DOTNET_ROOT=$HOMEPATH/.dotnet
export PATH="$PATH:/root/.dotnet/tools"

PKGE=(
  # LSP
  'csharp-ls'
  'csharpier'
)

for PKG in "${PKGE[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  dotnet tool install --global "$PKG"
  sync
  sleep 1s
done

."$HOMEPATH"/.tmux/plugins/tpm/bin/install_plugins
sync

cd "$HOMEPATH"/.config/tmux/plugins/tmux-thumbs
cargo build --release

sync

tmux source "$HOMEPATH"/.config/tmux/tmux.conf
sync

printf "export PATH=\$PATH:/snap/bin:\$HOME/.local/bin:\$HOME/.cargo/bin\n" | tee -a ~/.bashrc
printf "\nDOTNET_CLI_TELEMETRY_OPTOUT=1\n" | sudo tee -a /etc/environment
printf "FrameworkPathOverride=/lib/mono/4.8-api\n" | sudo tee -a /etc/environment

echo
echo "Done"
echo "Press alt+space shift+i to install tmux plugins and WAIT"
echo
sync
exit 0
