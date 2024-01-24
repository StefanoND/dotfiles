#! /bin/bash

# Bashrc
if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.bak
fi
ln -svf .bashrc ~/

# Bash Aliases
if [ -f ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/.bash_aliases.bak
fi
ln -svf ~/dotfiles/.bash_aliases ~/

# Bash logout
if [ -f ~/.bash_logout ]; then
  mv ~/.bash_logout ~/.bash_logout.bak
fi
ln -svf ~/dotfiles/.bash_logout ~/

# Editorconfig
if [ -f ~/.editorconfig ]; then
  mv ~/.editorconfig ~/.editorconfig.bak
fi
ln -svf ~/dotfiles/.editorconfig ~/

# Git Attributes
if [ -f ~/.gitattributes ]; then
  mv ~/.gitattributes ~/.gitattributes.bak
fi
ln -svf ~/dotfiles/.gitattributes ~/

# Git Config
if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/.gitconfig.bak
fi
ln -svf ~/dotfiles/.gitconfig ~/

# GTKRC-2 Garuda
if [ -f ~/.gtkrc-2.0.mine ]; then
  mv ~/.gtkrc-2.0.mine ~/.gtkrc-2.0.mine.bak
fi
ln -svf ~/dotfiles/.gtkrc-2.0.mine ~/

# Profile
if [ -f ~/.profile ]; then
  mv ~/.profile ~/.profile.bak
fi
ln -svf ~/dotfiles/.profile ~/

# Wezterm config
if [ -f ~/.wezterm.lua ]; then
  mv ~/.wezterm.lua ~/.wezterm.lua.bak
fi
ln -svf ~/dotfiles/.wezterm.lua ~/

# Nvim
if [ -f ~/.config/stvim ]; then
  mv ~/.config/stvim ~/.config/stvim.bak
fi
ln -svf ~/dotfiles/.config/stvim ~/.config/
# Nvim
if [ -f ~/.config/nvchad ]; then
  mv ~/.config/nvchad ~/.config/nvchad.bak
fi
ln -svf ~/dotfiles/.config/nvchad ~/.config/

# i3
if [ -f ~/.config/i3 ]; then
  mv ~/.config/i3 ~/.config/i3.bak
fi
ln -svf ~/dotfiles/.config/i3 ~/.config/

# tmux
if [ -d ~/.config/tmux ]; then
  mv ~/.config/tmux ~/.config/tmux.old
fi
mkdir ~/.config/tmux
ln -svf ~/dotfiles/.config/tmux ~/.config

if ! "$(pacman -Q | grep -iq 'tmux')"; then
  echo
  echo 'Installing tmux'
  echo
  sudo pacman -S tmux --noconfirm --needed
  sleep 1s
fi

if ! [ -f "$HOME"/.tmux/plugins/tpm ]; then
  echo
  echo 'Cloning tmux plugin manager'
  echo
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  sleep 1s
fi
