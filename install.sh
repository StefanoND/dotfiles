#! /bin/bash

if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.bak
fi
if [ -f ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/.bash_aliases.bak
fi
if [ -f ~/.bash_logout ]; then
  mv ~/.bash_logout ~/.bash_logout.bak
fi
if [ -f ~/.editorconfig ]; then
  mv ~/.editorconfig ~/.editorconfig.bak
fi
if [ -f ~/.gitattributes ]; then
  mv ~/.gitattributes ~/.gitattributes.bak
fi
if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/.gitconfig.bak
fi
if [ -f ~/.gtkrc-2.0.mine ]; then
  mv ~/.gtkrc-2.0.mine ~/.gtkrc-2.0.mine.bak
fi
if [ -f ~/.profile ]; then
  mv ~/.profile ~/.profile.bak
fi
if [ -f ~/.wezterm.lua ]; then
  mv ~/.wezterm.lua ~/.wezterm.lua.bak
fi

ln -svf .bashrc ~/
ln -svf .bash_aliases ~/
ln -svf .bash_logout ~/
ln -svf .editorconfig ~/
ln -svf .gitattributes ~/
ln -svf .gitconfig ~/
ln -svf .gtkrc-2.0.mine ~/
ln -svf .profile ~/
ln -svf .wezterm.lua ~/

if [ -f ~/.config/nvim ]; then
  mv ~/.config/nvim ~/.config/nvim.bak
fi

ln -svf .config/nvim ~/.config/

if [ -f ~/.config/i3 ]; then
  mv ~/.config/i3 ~/.config/i3.bak
fi

ln -svf .config/i3 ~/.config/
