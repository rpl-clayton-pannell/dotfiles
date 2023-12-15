#!/bin/sh

# Must be run from this directory

#install dotfiles
mv .vimrc ~/.vimrc
mkdir -p ~/.config/nvim
mv init.lua ~/.config/nvim/init.lua

# Allow VIM-Plug to autoinstall
nvim +qall
# Install Plugins
nvim +'PlugInstall' +qall
