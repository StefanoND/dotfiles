#!/usr/bin/env bash

if ! [ "$EUID" -ne 0 ]; then
  echo
  echo "Don't run this script as root"
  echo
  sleep 1s
  exit 1
fi

# For server using debian
#sudo apt install -y  && sync

rootpath=$HOME/dotfiles

mkdir -p "$HOME"/.vim/undodir

ln -svf "$rootpath"/.config/nvim_minimum "$HOME"/.config/

ln -svf "$rootpath"/.editorconfig "$HOME"/
ln -svf "$rootpath"/.clang-format "$HOME"/

sudo add-apt-repository universe

sudo apt update && sudo apt upgrade -y

# Apt - Neovim
PKGS=(
  # Neovim
  # 'neovim'
  'build-essential'
  'libssl-dev'
  'libreadline-dev'
  'zlib1g-dev'
  'ninja-build'
  'unzip'
  'gettext'
  'curl'
  'wget'
  'git'
  'clang'
  'clangd'
  'clang-tools'
  'clang-format'
  'clang-tidy'
  'make'
  'cmake'
  'cmake-extras'
  'ccache'
  'ispc'
  'g++-14'
  'g++-14-multilib'
  'gcc-14'
  'gcc-14-multilib'
  'fzf'
  'bat'
  'zoxide'
  'eza'
  'xclip'
  'xsel'
  'kitty'
  'kitty-shell-integration'
  'kitty-terminfo'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  sudo apt install -y "$PKG"
  sync
  sleep 1s
done

# Apt
PKGS=(
  #
  'luarocks'
  'rustup'  # Rust programming language software
  'ripgrep' # Better "grep"
  'fd-find' # Better "find"
  'shfmt'
  'shellcheck'
  'python3-pip'
  'python3-argcomplete'
  'python3'
  'pipx'
  'imagemagick'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | sudo pacman -S "$PKG" --needed
  sync
  sleep 1s
done

git clone --depth=1 https://github.com/neovim/neovim.git
git clone --depth=1 https://github.com/LuaLS/lua-language-server.git

# LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "vk*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_0.48.0_Linux_x86_64.tar.gz"
curl -Lo lua-5.4.7.tar.gz https://www.lua.org/ftp/lua-5.4.7.tar.gz
curl -Lo luarocks-3.11.1.tar.gz https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz
sudo tar -xf lazygit.tar.gz -C /usr/local/bin/

tar -xf lua-5.4.7.tar.gz
tar -xf luarocks-3.11.1.tar.gz

cd ~/lua-5.4.7
make all test
sudo make install

cd ~/luarocks-3.11.1
./configure --with-lua-include=/usr/local/include
make
sudo make install

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 23

/usr/local/bin/luarocks config local_by_default true
/usr/local/bin/luarocks install lua-utils

cd ~/lua-language-server
./make.sh

cd ~/neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

# PIP
PKGT=(
  # nvim Dependencies
  'pynvim'
  'cmake-language-server'
  'ue4cli'
  'gdtoolkit'
  'grip'
  'rollnw'
  'arclight'
)

for PKG in "${PKGT[@]}"; do
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

npm install --global all-the-package-names

npm install -g npm@latest

# npm i --package-lock-only
# sync
npm audit fix
sync
sleep 1s

# NPM
PKGTS=(
  # LSP
  # 'vscode-langservers-extracted'
  'bash-language-server'
  '@fsouza/prettierd'
  'yarn'
  '@vscode/vsce'
)

for PKG in "${PKGTS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  sudo npm i -g "$PKG"
  sync
  sleep 1s
done

npm audit fix
sync

# cd "$HOME"/.tmux/plugins/tmux-thumbs
# cargo build --release
# sync

# tmux source "$HOME"/.config/tmux/tmux.conf
# ."$HOME"/.tmux/plugins/tpm/bin/install_plugins
# sync

echo
echo "Done"
# echo "Press alt+space shift+i to install tmux plugins and WAIT"
echo
sync
exit 0
