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
ln -svf .bash_aliases ~/

# Bash logout
if [ -f ~/.bash_logout ]; then
  mv ~/.bash_logout ~/.bash_logout.bak
fi
ln -svf .bash_logout ~/

# Editorconfig
if [ -f ~/.editorconfig ]; then
  mv ~/.editorconfig ~/.editorconfig.bak
fi
ln -svf .editorconfig ~/

# Git Attributes
if [ -f ~/.gitattributes ]; then
  mv ~/.gitattributes ~/.gitattributes.bak
fi
ln -svf .gitattributes ~/

# Git Config
if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/.gitconfig.bak
fi
ln -svf .gitconfig ~/

# GTKRC-2 Garuda
if [ -f ~/.gtkrc-2.0.mine ]; then
  mv ~/.gtkrc-2.0.mine ~/.gtkrc-2.0.mine.bak
fi
ln -svf .gtkrc-2.0.mine ~/

# Profile
if [ -f ~/.profile ]; then
  mv ~/.profile ~/.profile.bak
fi
ln -svf .profile ~/

# Wezterm config
if [ -f ~/.wezterm.lua ]; then
  mv ~/.wezterm.lua ~/.wezterm.lua.bak
fi
ln -svf .wezterm.lua ~/

# Nvim
if [ -f ~/.config/stvim ]; then
  mv ~/.config/stvim ~/.config/stvim.bak
fi
ln -svf .config/stvim ~/.config/
# Nvim
if [ -f ~/.config/nvchad ]; then
  mv ~/.config/nvchad ~/.config/nvchad.bak
fi
ln -svf .config/stvim ~/.config/

# i3
if [ -f ~/.config/i3 ]; then
  mv ~/.config/i3 ~/.config/i3.bak
fi
ln -svf .config/i3 ~/.config/
