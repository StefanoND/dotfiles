#!/bin/bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

# Bashrc
if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/dotfiles/backup/
fi
ln -svf .bashrc ~/

# Bash Aliases
if [ -f ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.bash_aliases ~/

# Bash logout
if [ -f ~/.bash_logout ]; then
  mv ~/.bash_logout ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.bash_logout ~/

# Editorconfig
if [ -f ~/.editorconfig ]; then
  mv ~/.editorconfig ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.editorconfig ~/

# Git Attributes
if [ -f ~/.gitattributes ]; then
  mv ~/.gitattributes ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.gitattributes ~/

# Git Config
if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.gitconfig ~/

# GTKRC-2 Garuda
if [ -f ~/.gtkrc-2.0.mine ]; then
  mv ~/.gtkrc-2.0.mine ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.gtkrc-2.0.mine ~/

# Profile
if [ -f ~/.profile ]; then
  mv ~/.profile ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.profile ~/

# Wezterm config
if [ -f ~/.wezterm.lua ]; then
  mv ~/.wezterm.lua ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.wezterm.lua ~/

# Nvim
if [ -f ~/.config/nvim ]; then
  mv ~/.config/stvim ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.config/nvim ~/.config/

# i3
if [ -f ~/.config/i3 ]; then
  mv ~/.config/i3 ~/dotfiles/backup/
fi
ln -svf ~/dotfiles/.config/i3 ~/.config/

# tmux
if [ -d ~/.config/tmux ]; then
  mv ~/.config/tmux ~/dotfiles/backup/
fi
mkdir ~/.config/tmux
ln -svf ~/dotfiles/.config/tmux ~/.config

# VSCodium
if [ -d ~/.config/VSCodium ]; then
  mv ~/.config/VSCodium ~/dotfiles/backup/
fi
mkdir -p ~/.config/VSCodium/User
ln -svf ~/dotfiles/.config/VSCodium/User/settings.json ~/.config/VSCodium/User/
ln -svf ~/dotfiles/.config/VSCodium/User/keybindings.json ~/.config/VSCodium/User/

exit 0
