#!/bin/sh

# Must be run from this directory

#install dotfiles
mv .vimrc ~/.vimrc
mkdir -p ~/.config/nvim
mv init.vim ~/.config/nvim/init.vim
mkdir -p ~/.config/coc
mv coc-settings.json ~/.config/coc

# Allow VIM-Plug to autoinstall
nvim +qall
# Install Plugins
nvim +'PlugInstall' +qall
# Potentially pointless update of CoC
nvim +'CocUpdateSync' +qall

# Install CoC extensions
nvim +'CocInstall coc-pyright coc-clangd coc-rust-analyzer coc-json -sync' +qall
